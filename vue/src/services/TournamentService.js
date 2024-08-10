import axios from 'axios';
const http = axios.create({
    baseURL: import.meta.env.VITE_REMOTE_API
});

export default {
    getTournaments() {
        return http.get('/tournaments')
    },
    getTournament(id) {
        return http.get(`/tournaments/${id}`)
    },
    createTournament(tournament, authToken) {
        let authHeader = {headers:{"Authorization": `Bearer ${authToken}`}};
        return http.post('/tournaments', tournament,authHeader)
    },
    updateTournament(id, tournament,authToken) {
        let authHeader = {headers:{"Authorization": `Bearer ${authToken}`}};
        return http.put(`/tournaments/${id}/update`, tournament,authHeader)
    },
    getTournamentsByCreatorId(id) {
        return http.post('/tournaments/query', {
            filters: [
                {
                    filterProperty: "creatorId",
                    value: id
                }
            ],
            operator: "&",
            limit: 0
        });
    },
    getTournamentByFilter(filter) {
        return http.post('/tournaments/query', filter);
    }
    // deleteTournament(id) {
    //     return http.delete(`/tournaments/${id}`)
    // }
}



