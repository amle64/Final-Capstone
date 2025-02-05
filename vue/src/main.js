import { createApp } from 'vue'
import CapstoneApp from './App.vue'
import { createStore } from './store'
import router from './router'
import axios from 'axios'
import './assets/main.css'; // Import the global styles


/* sets the base url for server API communication with axios */
axios.defaults.baseURL = import.meta.env.VITE_REMOTE_API;

/*
 * The authorization header is set for axios when you login but what happens when 
 * you come back or the page is refreshed. When that happens you need to check 
 * for the token in local storage and if it exists you should set the header 
 * so that it will be attached to each request.
 */
let currentToken = localStorage.getItem('token');
let currentUser = JSON.parse(localStorage.getItem('user'));
let currentUserRole = localStorage.getItem('currentRole');
let isOrganizer = localStorage.getItem('isOrganizer');
let currentTournamentId = localStorage.getItem('tournamentId');
let currentTournamentCreatorId = localStorage.getItem('tournamentCreatorId');

if (currentToken) {
  // Set token axios requests
  axios.defaults.headers.common['Authorization'] = `Bearer ${currentToken}`;
}

// Create the Vuex store passing in the stored credentials
const store = createStore(currentToken, currentUser, currentUserRole, isOrganizer,currentTournamentId, currentTournamentCreatorId);

const app = createApp(CapstoneApp);
app.directive('visible', function(el, binding) {
  el.style.visibility = !!binding.value ? 'visible' : 'hidden';
}); 

app.use(store);
app.use(router);
app.mount('#app');