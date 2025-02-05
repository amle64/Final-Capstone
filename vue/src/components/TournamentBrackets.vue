<template>
    <div class="bracket-tree-container">
        <h5>{{ this.tournamentName }}</h5>
        <div class="tournament-bracket tournament-bracket--rounded">
            <bracket-list 
                v-for="(brackets, index) in bracketTree.slice().reverse()" 
                v-bind:brackets="brackets" 
                v-bind:treeFloor="index" 
                v-bind:treeFloorTotal="treeHeight" 
                v-bind:tournamentDate="tournamentDate"
            ></bracket-list>
        </div>
    </div>
</template>

<script>
import BracketService from '../services/BracketService';
import BracketList from './BracketList.vue';

export default {
    props: {
        tournamentId: {
            type: String,
            required: true
        },
        tournamentDate: {
            type: String,
            required: true
        },
        tournamentName: {
            type: String,
            required: true
        }
    },
    components: {
        BracketList
    }, 
    data() {
        return {
            bracketTree: []
        }
    },
    mounted() {
        this.getBracket();
    },
    computed: {
        treeHeight() {
            return Math.floor(Math.log2(this.bracketTree.length) + 1);
        }
    },
    methods: {
        getBracket() {
            BracketService.getBracketsByTournamentId(this.tournamentId).then(response => {
                if (response.status !== 200) return;
                const treeHeight = Math.floor(Math.log2(response.data.length) + 1);

                for (let level = 0, bracketCount = 0; level < treeHeight; level++) {
                    const maxBracketsPerFloor = Math.pow(2, level);
                    let brackets = [];

                    for (let bracketPos = 0; bracketPos < maxBracketsPerFloor; bracketPos++) {
                        let matchBracket = (response.data[bracketCount] != null) ? response.data[bracketCount] : {
                            bracketId: 0,
                            matchId: 0,
                            name: 'INVALID',
                            parentBracket: 0
                        };

                        brackets.push(matchBracket);
                        bracketCount++;
                    }

                    this.bracketTree.push(brackets);
                }
            }).catch(error => {
                console.log(error);
            })
        }
    } 
}
</script>

<style>
@import 'https://fonts.googleapis.com/css?family=Work+Sans:300,400,600,700&subset=latin-ext';

* {

    &,
    &::before,
    &::after {
        box-sizing: border-box;
    }
}

html {
    font-size: 15px;

    @media (min-width: 38em) {
        font-size: 14px;
    }

    @media (min-width: 52em) {
        font-size: 15px;
    }

    @media (min-width: 72em) {
        font-size: 16px;
    }
}

ul, video, li, ul, h1 {
    margin: 0;
    padding: 0;
    border: 0;
    font-size: 100%;
    font: inherit;
    vertical-align: baseline
}

body {
    line-height: 1
}

ol,
ul {
    list-style: none
}

table {
    border-collapse: collapse;
    border-spacing: 0
}

.bracket-tree-container {
    width: 90%;
    min-width: 18em;
    margin: 20px auto;

    & h4, h5 {
        text-align: center;
    }

    & h4 {
        font-size: 2rem;
        font-weight: 700;
        margin-bottom: 0.5em;
    }

    & h5 {
        font-size: 1.4rem;
        font-weight: 600;
        margin-bottom: 2em;
    }
}

.sr-only {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip: rect(0, 0, 0, 0);
    border: 0;
}

.tournament-bracket {
    display: flex;
    flex-direction: column;

    @media (min-width: 38em) {
        flex-direction: row;
    }
}

.tournament-bracket-round {
    display: block;
    margin-left: -3px;
    flex: 1;
}

.tournament-bracket-round-title {
    color: #2c3e50;
    font-size: 0.95rem;
    font-weight: 400;
    text-align: center;
    font-style: italic;
    margin-bottom: 0.5em;
}

.tournament-bracket-list {
    display: flex;
    flex-direction: column;
    flex-flow: row wrap;
    justify-content: center;
    height: 100%;
    min-height: 100%;
    border-bottom: 1px dashed #e5e5e5;
    padding-bottom: 2em;
    margin-bottom: 2em;
    transition: padding 0.2s ease-in-out, margin 0.2s ease-in-out;

    @media (max-width: 24em) {
        padding-bottom: 1em;
        margin-bottom: 1em;
    }

    @media (min-width: 38em) {
        margin-bottom: 0;
        padding-bottom: 0;
        border-right: 1px dashed #e5e5e5;
        border-bottom: 0;
    }

    .tournament-bracket-round:last-child & {
        border: 0;
    }
}

.tournament-bracket-item {
    display: flex;
    flex: 0 1 auto;
    justify-content: center;
    flex-direction: column;
    align-items: flex-start;
    position: relative;
    padding: 2% 0;
    width: 48%;
    transition: padding 0.2s linear;

    &:nth-child(odd) {
        margin-right: 2%;
    }

    &:nth-child(even) {
        margin-left: 2%;
    }

    &::after {
        transition: width 0.2s linear;
    }

    @media (max-width: 24em) {
        width: 100%;

        &:nth-child(odd),
        &:nth-child(even) {
            margin-left: 0;
            margin-right: 0;
        }
    }

    @media (min-width: 38em) {
        padding: 0.5em 1em;
        /* flex-grow: 2; */
        width: 100%;

        &:nth-child(odd),
        &:nth-child(even) {
            margin: 0;
        }

        &::after {
            position: absolute;
            right: 0;
            content: '';
            display: block;
            width: 1em;
            height: 30%;
            border-right: 2px solid #9e9e9e;
            border-top-right-radius: 10px;
        }

        &:nth-child(odd)::after {
            top: 50%;
            border-top: 2px solid #9e9e9e;
            border-top-right-radius: 10px;
            transform: translateY(-1px);

            .tournament-bracket--rounded & {
                border-top-right-radius: 0.6em;
            }
        }

        &:nth-child(even)::after {
            bottom: 50%;
            border-bottom: 2px solid #9e9e9e;
            border-bottom-right-radius: 10px;
            border-top-right-radius: 0px;
            transform: translateY(1px);

            .tournament-bracket--rounded & {
                border-bottom-right-radius: 0.6em;
            }
        }

        .tournament-bracket-round:first-child & {
            padding-left: 0;
        }

        .tournament-bracket-round:last-child & {
            padding-right: 0;

            &::after {
                display: none;
            }
        }
    }

    @media (min-width: 72em) {
        padding: 0.5em 1.5em;

        &::after {
            width: 1.5em;
        }
    }
}


.tournament-bracket-match {
    display: flex;
    width: 100%;
    background: linear-gradient(135deg, #2c3e50, #34495e);
    padding: 1em;
    border: 1px solid transparent;
    border-radius: 0.5em;
    box-shadow: 0 2px 0 0 #e5e5e5;
    outline: none;
    transition: padding 0.2s ease-in-out, border 0.2s linear;

    &:focus {
        border-color: #2196F3;
    }

    &::before,
    &::after {
        transition: all 0.2s linear;
    }

    @media (max-width: 24em) {
        padding: 0.75em 0.5em;
    }

    @media (min-width: 38em) {

        &::before,
        &::after {
            position: absolute;
            left: 0;
            z-index: 0;
            content: '';
            display: block;
            width: 1em;
            height: 10%;
            border-left: 2px solid #9e9e9e;
        }

        &::before {
            bottom: 50%;
            border-bottom: 2px solid #9e9e9e;
            border-bottom-left-radius: 20px;
            transform: translate(0, 1px);

            .tournament-bracket--rounded & {
                border-bottom-left-radius: 0.6em;
            }
        }

        &::after {
            top: 50%;
            border-top: 2px solid #9e9e9e;
            border-top-left-radius: 20px;
            transform: translate(0, -1px);

            .tournament-bracket--rounded & {
                border-top-left-radius: 0.6em;
            }
        }
    }

    @media (min-width: 72em) {

        &::before,
        &::after {
            width: 1.5em;
        }

        &::before {
            transform: translate(0, 1px);
        }

        &::after {
            transform: translate(0, -1px);
        }
    }
}

.tournament-bracket-round:last-child .tournament-bracket-match {

    &::before,
    &::after {
        height: 20%;
        transform: translate(0.7px)
    }
}

.tournament-bracket-round:first-child .tournament-bracket-match {

    &::before,
    &::after {
        display: none;
    }
}

.tournament-bracket-content {
    display: flex;

    &::after {
        content: ':';
        width: 1em;
        text-align: center;
        padding: 0.2em 0.1em;

        @media (min-width: 38em) {
            order: 1;
        }
    }

    & .tournament-bracket-team:first-child {
        width: 50%;
        order: 0;
        text-align: right;

        @media (min-width: 38em) and (max-width: 52em) {
            align-items: flex-end;
        }

        & .tournament-bracket-competitor {
            order: 2;
            justify-content: flex-end;

            @media (min-width: 24em) {
                order: 0;
            }

            @media (min-width: 38em) and (max-width: 52em) {
                flex-direction: column-reverse;
                align-items: flex-end;
            }
        }

        & .tournament-bracket-score {
            order: 0;

            @media (min-width: 24em) {
                order: 2;
            }
        }
    }

    & .tournament-bracket-team:last-child {
        width: 50%;
        order: 2;
        text-align: left;

        @media (min-width: 38em) and (max-width: 52em) {
            align-items: flex-start;
        }

        & .tournament-bracket-competitor {
            @media (min-width: 38em) {
                justify-content: flex-start;
            }

            @media (min-width: 38em) and (max-width: 52em) {
                align-items: flex-start;
            }
        }

        .tournament-bracket-code {
            order: 1;
        }
    }
}


.tournament-bracket-table {
    width: 100%;
}

.tournament-bracket-caption {
    font-size: 0.8rem;
    color: #BDBDBD;
    font-weight: 300;
    padding-bottom: 0.75em;
}

.tournament-bracket-team {
    display: flex;
    flex-direction: row-reverse;
    justify-content: space-between;

    @media (min-width: 24em) {
        flex-direction: column-reverse;
    }

    @media (min-width: 38em) {
        flex-direction: column-reverse;
    }
}

.tournament-bracket-competitor {
    font-size: 0.95rem;
    display: flex;
    margin-top: 0.5em;
    align-items: center;

    @media (max-width: 24em) {
        margin-top: 0;
    }

    @media (min-width: 38em) and (max-width: 52em) {
        display: flex;
        flex-direction: column;

        .tournament-bracket-code {
            margin-top: 0.2em;
        }
    }

    & .tournament-bracket-competitor-name {
        color: #ffffff;
    }
}

.tournament-bracket-code {
    padding: 0 0.5em;
    color: #212121;
    font-weight: 600;
    text-transform: uppercase;
    border: 0;
    text-decoration: none;
    cursor: help;
    transition: padding 0.2s ease-in-out;

    @media (max-width: 24em) {
        padding: 0 0.25em;
    }

    @media (min-width: 38em) and (max-width: 52em) {
        padding: 0;
    }
}

.tournament-bracket-score {
    display: flex;
    align-items: center;

    .tournament-bracket-team:first-child & {
        flex-direction: row-reverse;
        padding-left: 0.75em;
    }

    .tournament-bracket-team:last-child & {
        padding-right: 0.75em;
    }
}

.tournament-bracket-number {
    display: inline-block;
    padding: 0.2em 0.4em 0.2em;
    border-bottom: 0.075em solid transparent;
    font-size: 0.95rem;
    background-color: #F5F5F5;
    border-color: spin(shade(#F5F5F5, 10%), -10);

    .tournament-bracket-team--winner & {
        background-color: #FFF176;
        border-color: spin(shade(#FFF176, 2%), -10);
    }
}

.tournament-bracket-medal {
    padding: 0 0.5em;
}

.tournament-bracket-medal--gold {
    color: #FFD700;
}

.tournament-bracket-medal--silver {
    color: #C0C0C0;
}

.tournament-bracket-medal--bronze {
    color: #CD7F32;
}
</style>