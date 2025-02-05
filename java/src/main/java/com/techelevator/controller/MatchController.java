package com.techelevator.controller;

import com.techelevator.dao.JdbcMatchDao;
import com.techelevator.dao.MatchDao;
import com.techelevator.exception.DaoException;
import com.techelevator.model.Match;
import com.techelevator.model.MatchDto;
import org.springframework.http.HttpStatus;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

@RestController
@RequestMapping("/matches")
@PreAuthorize("isAuthenticated()")
@CrossOrigin
public class MatchController {
    //Basic methods are created but not tested yet
    private final MatchDao matchDao;

    public MatchController(JdbcTemplate jdbcTemplate){
        matchDao = new JdbcMatchDao(jdbcTemplate);
    }

    //Allow all users to access matches
    @RequestMapping(method=RequestMethod.GET)
    @PreAuthorize("permitAll")
    public List<Match> getAllMatches(){
        List<Match> matches = new ArrayList<>();

        try {
            matches = matchDao.getMatches();
            if (matches.isEmpty()) {
                throw new ResponseStatusException(
                        HttpStatus.NOT_FOUND, "Unable to locate games");
            }
        } catch (DaoException ex) {
            throw new ResponseStatusException(
                    HttpStatus.REQUEST_TIMEOUT, ex.getMessage()
            );
        }
        return matches;
    }

    @PreAuthorize("permitAll")
    @RequestMapping(path="/{matchId}",method=RequestMethod.GET)
    public Match getMatchById(@PathVariable int matchId){
        Match match;

        try{
            match = matchDao.getMatchById(matchId);
            if(match == null){
                throw new ResponseStatusException(
                        HttpStatus.NOT_FOUND, "Unable to locate match by match ID: "+matchId);
            }
        }catch (DaoException ex){
            throw new ResponseStatusException(
                    HttpStatus.REQUEST_TIMEOUT, ex.getMessage()
            );
        }
        return match;
    }

    @RequestMapping(path = "/player/{playerId}", method=RequestMethod.GET)
    @PreAuthorize("permitAll")
    public List<Match> getMatchesByPlayerId(@PathVariable int playerId){
        List<Match> matches = new ArrayList<>();

        try {
            matches = matchDao.getMatchesByPlayerId(playerId);
            if (matches.isEmpty()) {
                throw new ResponseStatusException(
                        HttpStatus.NOT_FOUND, "Unable to locate player's games");
            }
        } catch (DaoException ex) {
            throw new ResponseStatusException(
                    HttpStatus.REQUEST_TIMEOUT, ex.getMessage()
            );
        }
        return matches;
    }


    @RequestMapping(path = "/tournaments/{tournamentId}", method=RequestMethod.GET)
    @PreAuthorize("permitAll")
    public List<Match> getMatchesByTournamentId(@PathVariable int tournamentId){
        List<Match> matches = new ArrayList<>();

        try {
            matches = matchDao.getMatchesByTournamentId(tournamentId);
            if (matches.isEmpty()) {
                throw new ResponseStatusException(
                        HttpStatus.NOT_FOUND, "Unable to locate matches for tournament " + tournamentId);
            }
        } catch (DaoException ex) {
            throw new ResponseStatusException(
                    HttpStatus.REQUEST_TIMEOUT, ex.getMessage()
            );
        }
        return matches;
    }

    @RequestMapping(path="/{matchId}/update", method = RequestMethod.PUT)
    public Match updateMatch(@RequestBody @Valid MatchDto match, @PathVariable int matchId){
        Match updatedMatch, previous = matchDao.getMatchById(matchId);

        try{
            if(match.getMatchId() != matchId){
                throw new ResponseStatusException(
                        HttpStatus.BAD_REQUEST, "MatchID in the requestBody is not matching the path variable"
                );
            }

            int rowsAffected = (match.getPlayer1Id() == null || match.getPlayer2Id() == null) ?
                    matchDao.updateMatch(match) : matchDao.updateParent(match);

            if (rowsAffected == 0){
                throw new ResponseStatusException(
                        HttpStatus.NOT_FOUND,"Unable to update tournament "+matchId);
            }

            updatedMatch = matchDao.getMatchById(matchId);

        }catch(DaoException e){
            throw new ResponseStatusException(
                    HttpStatus.BAD_REQUEST, e.getMessage()
            );
        }
        return updatedMatch;
    }

    @RequestMapping(method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.CREATED)
    public Match createMatch(@RequestBody Match match){
        Match newMatch;

        try{
            newMatch = matchDao.createMatch(match);
            if(newMatch == null) throw new ResponseStatusException(
                    HttpStatus.NOT_FOUND, "Unable locate match"
            );

        } catch(DaoException ex) {
            throw new ResponseStatusException(
                HttpStatus.REQUEST_TIMEOUT, ex.getMessage()
            );
        }

        return newMatch;
    }

    @RequestMapping(path = "/{matchId}/parent", method = RequestMethod.GET)
    @PreAuthorize("permitAll")
    public Match getMatchParent(@PathVariable int matchId) {
        Match parent;

        try {
            parent = matchDao.getParentMatch(matchId);
        } catch (DaoException ex) {
            throw new ResponseStatusException(
                    HttpStatus.NOT_FOUND, "Unable locate match"
            );
        }

        return parent;
    }

    @RequestMapping(path = "/array-create", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.CREATED)
    public List<Match> createMatches(@RequestBody List<Match> matches) {
        List<Match> newMatches = new ArrayList<>();

        try {
            for (Match match : matches) {
                Match newMatch = matchDao.createMatch(match);
                if (newMatch == null) throw new ResponseStatusException (
                        HttpStatus.NOT_FOUND, "Unable locate match"
                );

                newMatches.add(newMatch);
            }
        } catch (DaoException ex) {
            throw new ResponseStatusException(
                    HttpStatus.REQUEST_TIMEOUT, ex.getMessage()
            );
        }

        return newMatches;
    }


}
