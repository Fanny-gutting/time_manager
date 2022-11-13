<script lang="ts">
export default {
    data() {
        return {
            users: [] as { id: Number, username: String, email: String, status: Number }[],
            members: [] as { id: Number, username: String, email: String, status: Number }[],
            teams: [] as {
                id: Number, title: String, leader: {
                    email: String,
                    id: Number,
                    status: Number,
                    username: String
                },
                members: any,
            }[],
            search: {
                type: String,
                default: "",
            },
            id: {
                type: Number,
                default: 0
            },
            title: {
                type: String,
                default: "",
            },
            leader: {
                email: {
                    type: String,
                    default: ""
                },
                id: {
                    type: Number,
                    default: 0
                },
                status: {
                    type: Number,
                    default: 0
                },
                username: {
                    type: String,
                    default: "username"
                },
            },
        }
    },
    emits: ['menuSelection'],
    methods: {
        async GetUsers() {
            try {
                axios.get('http://localhost:4000/api/users').then(resp => {
                    console.log("data is = ", resp.data.data);
                    this.users = resp.data.data;
                    return this.users;
                });
            } catch (error) {
                console.log(error);
            }
        },
        async GetTeams() {
            try {
                axios.get('http://localhost:4000/api/teams').then(resp => {
                    this.teams = resp.data.data;
                    return this.teams;
                });
            } catch (error) {
                console.log(error);
            }
        },
        setTeamCreationModif(title: string, user: { id: number, email: string; status: number; username: string; }) {
            // this.id.default = team.id;
            this.title.default = title;
            this.leader.email.default = user.email
            this.leader.id.default = user.id
            this.leader.status.default = user.status
            this.leader.username.default = user.username
        },
        setTeamModif(team: {
            id: number, title: string, leader: {
                email: string,
                id: number,
                status: number,
                username: string
            }
        }) {
            this.id.default = team.id;
            this.title.default = team.title;
            this.leader.email.default = team.leader.email
            this.leader.id.default = team.leader.id
            this.leader.status.default = team.leader.status
            this.leader.username.default = team.leader.username
        },
        resetTeamModif() {
            this.id.default = 0;
            this.title.default = "";
            this.leader.email.default = "";
            this.leader.id.default = 0;
            this.leader.status.default = 0;
            this.leader.username.default = "";
        },
        async CreateTeam() {
            try {
                let payload = {
                    team: {
                        title: this.title.default,
                    }
                };
                let res = await axios.post('http://localhost:4000/api/teams/' + this.leader.id.default, payload);

                let data = res.data;
                console.log(data);
                this.id.default = 0;
                this.title.default = "";
                this.leader.email.default = "";
                this.leader.id.default = 0;
                this.leader.status.default = 0;
                this.leader.username.default = "";
            } catch (error) {
                console.log(error);
            }
        },
        async DeleteTeam(id: number) {
            try {
                let res = await axios.delete('http://localhost:4000/api/teams/' + id);

                let data = res.data;
                console.log(data);
                this.id.default = 0;
                this.title.default = "";
                this.leader.email.default = "";
                this.leader.id.default = 0;
                this.leader.status.default = 0;
                this.leader.username.default = "";
            } catch (error) {
                console.log(error);
            }
        },
        async updateTeamModif() {
            try {
                let payload = {
                    team: {
                        title: this.title.default,
                        user_id: this.leader.id.default
                    }
                };
                console.log("user info = ", this.id.default)
                console.log('http://localhost:4000/api/teams/' + this.id.default)

                let res = await axios.put('http://localhost:4000/api/teams/' + this.id.default, payload);

                let data = res.data;
                console.log(data);
                this.id.default = 0;
                this.title.default = "";
                this.leader.email.default = "";
                this.leader.id.default = 0;
                this.leader.status.default = 0;
                this.leader.username.default = "";
            } catch (error) {
                console.log(error);
            }
        },
        async AddTeamMember(teamId: number, userId: number) {
            try {
                let payload = {
                    team_user: {
                        user_id: userId,
                        team_id: teamId
                    }
                };
                let res = await axios.post('http://localhost:4000/api/teamusers', payload);

                let data = res.data;
                console.log(data);
                this.GetUsers();
                this.GetTeams();
            } catch (error) {
                console.log(error);
            }
        },
        async DeleteTeamMember(teamId: number, userId: number) {
            try {
                console.log("team id = ", teamId)
                console.log("user id = ", userId)
                let res = await axios.delete('http://localhost:4000/api/teamusers/?team_id=' + teamId + '&user_id=' + userId);

                let data = res.data;
                console.log(data);
                this.GetUsers();
                this.GetTeams();
            } catch (error) {
                console.log(error);
            }
        },
    }
}
</script>
<script lang="ts" setup>
import axios from 'axios';
import { ref } from "vue";
let inputUsers = ref("");
let inputTeams = ref("");


function filterUsers(users: Array<any>) {
    // console.log(users);
    return users.filter((user) =>
        user.username.toLowerCase().includes(inputUsers.value.toLowerCase())
    );
}
function filterTeams(teams: Array<any>) {
    return teams.filter((team) =>
        team.title.toLowerCase().includes(inputTeams.value.toLowerCase())
    );
}
function filterTeamUsers(idteam: number, teams: Array<any>) {
    let i = 0;
    if (idteam) {
        for (let i = 0; i < teams.length; i++) {
            if (teams[i].id == idteam) {
                return teams[i].users.filter((user: any) =>
                    user.username.toLowerCase().includes(inputTeams.value.toLowerCase())
                );
            }
        }
    }
}
function filterNonTeamUsers(idteam: number, teams: Array<any>, users: Array<any>) {
    let usersTemp = [];
    usersTemp = users;
    if (idteam) {
        for (let i = 0; i < teams.length; i++) {
            if (teams[i].id == idteam) {
                for (let j = 0; j < teams[i].users.length; j++) {
                    for (let k = 0; k < usersTemp.length; k++) {
                        if (usersTemp[k].id == teams[i].users[j].id) {
                            usersTemp.splice(k, 1);
                        }
                    }
                }
                return usersTemp.filter((user: any) =>
                    user.username.toLowerCase().includes(inputUsers.value.toLowerCase())
                );
            }
        }
    }
}
</script>

<template>
    <div class="absolute top-0 left-100">
        <label for="my-modal" class="btn" v-on:click="GetUsers()">Create a new team</label>
        <input type="checkbox" id="my-modal" class="modal-toggle" />
        <div class="modal">
            <div class="modal-box relative" for="">
                <label for="my-modal" class="btn btn-sm btn-circle absolute right-2 top-2"
                    v-on:click="resetTeamModif()">✕</label>
                <p>Title :</p>
                <input v-model="title.default" placeholder="TeamTitle" />
                <p>Team leader :</p>
                <p>{{ leader.username.default }}</p>
                <input type="text" v-model="inputUsers" placeholder="Search user..." />
                <div class="btn btn-xs sm:btn-sm md:btn-md lg:btn-md" v-for="user in filterUsers(users)"
                    v-on:click="setTeamCreationModif(title.default, user)" :key="user">
                    <p>{{ user.username }}</p>
                </div>
                <div class="btn btn-xs sm:btn-sm md:btn-md lg:btn-md btn-disabled"
                    v-if="inputUsers && !filterUsers(users).length">
                    <p>No results found</p>
                </div>
                <div class="modal-action">
                    <label for="my-modal" class="btn" v-on:click="resetTeamModif()">cancel</label>
                    <label for="my-modal" class="btn" v-on:click="CreateTeam()">create team</label>
                </div>
            </div>
        </div>

        <label for="my-modal2" class="btn" v-on:click="GetTeams(), GetUsers()">Modify a team</label>
        <input type="checkbox" id="my-modal2" class="modal-toggle" />
        <div class="modal">
            <div class="modal-box relative" for="">
                <label for="my-modal2" class="btn btn-sm btn-circle absolute right-2 top-2"
                    v-on:click="resetTeamModif()">✕</label>

                <input type="text" v-model="inputTeams" placeholder="Search a team..." />
                <div class="btn btn-xs sm:btn-sm md:btn-md lg:btn-md" v-for="team in filterTeams(teams)"
                    v-on:click="setTeamModif(team)" :key="team">
                    <p>{{ team.title }}</p>
                </div>
                <div class="btn btn-xs sm:btn-sm md:btn-md lg:btn-md btn-disabled"
                    v-if="inputTeams && !filterTeams(teams).length">
                    <p>No results found</p>
                </div>
                <p>Title</p>
                <input v-model="title.default" placeholder="TeamTitle" />
                <p>Team leader :</p>
                <p>{{ leader.username.default }}</p>
                <input type="text" v-model="inputUsers" placeholder="Search user..." />
                <div class="btn btn-xs sm:btn-sm md:btn-md lg:btn-md" v-for="user in filterUsers(users)"
                    v-on:click="setTeamCreationModif(title.default, user)" :key="user">
                    <p>{{ user.username }}</p>
                </div>
                <div class="btn btn-xs sm:btn-sm md:btn-md lg:btn-md btn-disabled"
                    v-if="inputUsers && !filterUsers(users).length">
                    <p>No results found</p>
                </div>
                <div class="modal-action">
                    <label for="my-modal2" class="btn" v-on:click="resetTeamModif()">cancel</label>
                    <label for="my-modal2" class="btn" v-on:click="updateTeamModif()">update informations</label>
                </div>
            </div>
        </div>


        <label for="my-modal3" class="btn" v-on:click="GetTeams(), GetUsers()">Delete a team</label>
        <input type="checkbox" id="my-modal3" class="modal-toggle" />
        <div class="modal">
            <div class="modal-box relative" for="">
                <label for="my-modal3" class="btn btn-sm btn-circle absolute right-2 top-2"
                    v-on:click="resetTeamModif()">✕</label>
                <input type="text" v-model="inputTeams" placeholder="Search a team..." />
                <div class="btn btn-xs sm:btn-sm md:btn-md lg:btn-md" v-for="team in filterTeams(teams)"
                    v-on:click="setTeamModif(team)" :key="team">
                    <p>{{ team.title }}</p>
                </div>
                <div class="btn btn-xs sm:btn-sm md:btn-md lg:btn-md btn-disabled"
                    v-if="inputTeams && !filterTeams(teams).length">
                    <p>No results found</p>
                </div>
                <p>Team title :</p>
                <p>{{ title.default }}</p>
                <p>Team leader :</p>
                <p>{{ leader.username.default }}</p>
                <div class="modal-action">
                    <label for="my-modal3" class="btn" v-on:click="resetTeamModif()">cancel</label>
                    <label for="my-modal3" class="btn" v-on:click="DeleteTeam(id.default)">delete a team</label>
                </div>
            </div>
        </div>

        <label for="my-modal4" class="btn" v-on:click="GetTeams(), GetUsers()">Add/remove members to a team</label>
        <input type="checkbox" id="my-modal4" class="modal-toggle" />
        <div class="modal">
            <div class="modal-box relative" for="">
                <label for="my-modal4" class="btn btn-sm btn-circle absolute right-2 top-2"
                    v-on:click="resetTeamModif()">✕</label>

                <input type="text" v-model="inputTeams" placeholder="Search a team..." />
                <div class="btn btn-xs sm:btn-sm md:btn-md lg:btn-md" v-for="team in filterTeams(teams)"
                    v-on:click="setTeamModif(team)" :key="team">
                    <p>{{ team.title }}</p>
                </div>
                <div class="btn btn-xs sm:btn-sm md:btn-md lg:btn-md btn-disabled"
                    v-if="inputTeams && !filterTeams(teams).length">
                    <p>No results found</p>
                </div>
                <p>Team leader :</p>
                <p>{{ leader.username.default }}</p>

                <div class="collapse">
                    <input type="checkbox" class="peer" />
                    <div class="collapse collapse-title collapse-arrow peer-checked:text-secondary-content"
                        v-on:click="GetTeams(), GetUsers()">
                        Remove Team members
                    </div>
                    <div class="collapse-content peer-checked:text-secondary-content ">
                        <div class="btn btn-xs sm:btn-sm md:btn-md lg:btn-md"
                            v-for="user in filterTeamUsers(id.default, teams)"
                            v-on:click="DeleteTeamMember(id.default, user.id), GetTeams(), GetUsers(), filterTeamUsers(id.default, teams)"
                            :key="user">
                            <p>{{ user.username }}</p>
                        </div>
                        <div class="btn btn-xs sm:btn-sm md:btn-md lg:btn-md btn-disabled"
                            v-if="inputUsers && !filterTeamUsers(id.default, teams).length">
                            <p>No results found</p>
                        </div>
                    </div>
                </div>
                <div class="collapse">
                    <input type="checkbox" class="peer" />
                    <div class="collapse collapse-title collapse-arrow peer-checked:text-secondary-content"
                        v-on:click="GetTeams(), GetUsers()">
                        Add team members
                    </div>
                    <div class="collapse-content peer-checked:text-secondary-content ">
                        <div class="btn btn-xs sm:btn-sm md:btn-md lg:btn-md"
                            v-for="user in filterNonTeamUsers(id.default, teams, users)"
                            v-on:click="AddTeamMember(id.default, user.id), GetTeams(), GetUsers(), filterNonTeamUsers(id.default, teams, users)"
                            :key="user">
                            <p>{{ user.username }}</p>
                        </div>
                        <div class="btn btn-xs sm:btn-sm md:btn-md lg:btn-md btn-disabled"
                            v-if="inputUsers && !filterNonTeamUsers(id.default, teams, users).length">
                            <p>No results found</p>
                        </div>
                    </div>
                </div>
                <div class="modal-action">
                    <label for="my-modal4" class="btn" v-on:click="resetTeamModif()">cancel</label>
                    <label for="my-modal4" class="btn" v-on:click="resetTeamModif()">update informations</label>
                </div>
            </div>
        </div>


    </div>
</template>

<style scoped>
input {
    color: #111;
}
</style>