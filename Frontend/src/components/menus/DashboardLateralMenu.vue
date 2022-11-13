<script lang="ts">

export default {
    props: {
        userType: String,
        UserId: Number,
        UserEmail: String,
        UserUsername: String,
        UserStatus: Number
    },
    emits: ['menuSelection'],

    methods: {
        settingsMenu(){
            console.log("settings");
            this.$emit('menuSelection', "2", this.UserId, this.UserEmail, this.UserUsername, this.UserStatus);
        },
        infoMenu(){
            console.log("info");
            this.$emit('menuSelection', "3", this.UserId, this.UserEmail, this.UserUsername, this.UserStatus);
        },
        async logOut() {
            try {
                console.log("sign out");
                let res = await axios.delete('http://localhost:4000/api/users/sign_out');
                let data = res.data;
                console.log("data = ", data)
                this.$emit('menuSelection', "0");
            } catch (error) {
                console.log(error);
            }
        },
    }
}
</script>
<script lang="ts" setup>
import { RouterLink, RouterView } from 'vue-router'
import axios from 'axios';
</script>

<template>
    <div class="sidenav">
        <div class="avatar flex justify-center mt-10">
            <div class="w-48 rounded-full">
                <img src="../../assets/images/Batman.png" />
            </div>
        </div>
        <div class="settings-row">
            <button v-on:click="settingsMenu()" class="btn btn-primary btn-ghost text-lightgray hover:text-yellow">settings</button>
            <button v-on:click="infoMenu()" class="btn btn-primary btn-ghost text-lightgray hover:text-yellow">info</button>
            <RouterLink class="btn btn-primary btn-ghost text-lightgray hover:text-yellow" to="/" v-on:click="logOut()">log out</RouterLink>
        </div>
        <nav>
            <li><RouterLink to="/clocking" class="text-lightgray hover:text-yellow hover:bg-transparent focus:text-yellow focus:bg-lightgray focus:border-l-4 focus:border-t-0 focus:border-b-0 focus:border-r-0 focus:border-yellow">Report departure/arrival</RouterLink></li>
            <li><RouterLink to="/dashboard" class="text-lightgray hover:text-yellow hover:bg-transparent focus:text-yellow focus:bg-lightgray focus:border-l-4 focus:border-t-0 focus:border-b-0 focus:border-r-0 focus:border-yellow">Dasboard</RouterLink></li>
            <!-- Everybody's functions above -->
            <li v-if="userType!=='employee'"><RouterLink to="/manageTeamsMenu" class="text-lightgray hover:text-yellow hover:bg-transparent focus:text-yellow focus:bg-gray focus:border-l-4 focus:border-t-0 focus:border-b-0 focus:border-r-0 focus:border-yellow">Manage teams</RouterLink></li>
            <!-- in Manage teams, dealing with creation of teams, assignation of employees in them, and also viewing the teams average working hours -->
            <li v-if="userType==='manager'"><RouterLink to="/dashboard" class="text-lightgray hover:text-yellow hover:bg-transparent focus:text-yellow focus:bg-gray focus:border-l-4 focus:border-t-0 focus:border-b-0 focus:border-r-0 focus:border-yellow">Employee's dashboards</RouterLink></li>
            <!-- in Employee's dashboard, also shows the employees working hours -->
            <!-- Manager and General manager functions above -->
            <li v-if="userType!=='employee' && userType!=='manager'"><RouterLink to="/dashboard" class="text-lightgray hover:text-yellow hover:bg-transparent focus:text-yellow focus:bg-gray focus:border-l-4 focus:border-t-0 focus:border-b-0 focus:border-r-0 focus:border-yellow">Employee and manager's dashboards</RouterLink></li>
            <!-- same thing as "Employee's dashboards" above, just a name changer for the general manager -->
            <li v-if="userType!=='employee' && userType!=='manager'"><RouterLink to="/manageAccountsMenu" class="text-lightgray hover:text-yellow hover:bg-transparent focus:text-yellow focus:bg-gray focus:border-l-4 focus:border-t-0 focus:border-b-0 focus:border-r-0 focus:border-yellow">Manage accounts</RouterLink></li>
            <!-- in manage accounts, deals with creation, modification, and deletion of accounts, as well as the promotion of accounts -->
            <!-- General manager's functions above -->

        </nav>
    </div>
    <div class="main">
        <RouterView />
    </div>
</template>

<style scoped>
.sidenav {
    height: 100%;
    width: 300px;
    position: fixed;
    z-index: 1;
    top: 0;
    left: 0;
    background-color: #111;
    overflow-x: hidden;
    padding-top: 0px;
}

.settings-row {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    padding: 15px;
    padding-bottom: 50px;
    font-size: 25px;
}

li {
    padding: 15px;
    border-bottom: 1px solid rgb(49, 41, 41);

}

li:last-child {
    border-bottom: none;
}

.main {
    margin-left: 350px;
    font-size: 28px;
}

nav {
    width: 100%;
    font-size: 25px;
    text-align: left;
    margin-top: 10px;
}


nav a.router-link-exact-active:hover {
    background-color: transparent;
}

nav a {
    display: inline-block;
    padding: 0 1rem;
}
</style>