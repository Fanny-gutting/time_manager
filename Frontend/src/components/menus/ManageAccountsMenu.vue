<script lang="ts">
export default {
    data() {
        return {
            users: [] as { id: Number, username: String, email: String, status: Number }[],
            search: {
                type: String,
                default: "",
            },
            id: {
                type: Number,
                default: 0
            },
            email: {
                type: String,
                default: "",
            },
            username: {
                type: String,
                default: "",
            },
            status: {
                type: Number,
                default: 3,
            },
            statusName: {
                type: String,
                default: "Employee",
            },
        }
    },
    methods: {
        async GetUsers() {
            try {
                console.log("in the api call")
                axios.get('http://localhost:4000/api/users').then(resp => {
                    console.log("data is = ",resp.data.data);
                    this.users = resp.data.data;
                    return this.users;
                });
            } catch (error) {
                console.log(error);
            }
        },
        setUserModif(user: { id: number, email: string; status: number; username: string; }) {
            this.id.default = user.id;
            this.email.default = user.email;
            this.status.default = user.status;
            this.username.default = user.username;
            if (this.status.default == 3)
                this.statusName.default = "Employee"
            else if (this.status.default == 2)
                this.statusName.default = "Manager";
            else if (this.status.default == 1)
                this.statusName.default = "General manager";
        },
        resetUserModif() {
            this.id.default = 0;
            this.username.default = "";
            this.email.default = "";
            this.status.default = 3;
        },
        setStatus(role: string) {

            if (role == "Employee") {
                this.statusName.default = "Employee";
                this.status.default = 3;
            }
            else if (role == "Manager") {
                this.statusName.default = "Manager";
                this.status.default = 2;
            }
            else if (role == "General manager") {
                this.statusName.default = "General manager";
                this.status.default = 1;
            }
        },
        async CreateUser() {
            try {
                let payload = {
                    user: {
                        username: this.username.default,
                        email: this.email.default,
                        status: this.status.default,
                    }
                };
                let res = await axios.post('http://localhost:4000/api/users', payload);

                let data = res.data;
                console.log(data);
                this.id.default = 0;
                this.username.default = "";
                this.email.default = "";
                this.status.default = 3;
            } catch (error) {
                console.log(error);
            }
        },
        async DeleteUser(user: { id: number, email: string; status: number; username: string; } ) {
            try {
                let res = await axios.delete('http://localhost:4000/api/' + user.id);

                let data = res.data;
                console.log(data);
                this.id.default = 0;
                this.username.default = "";
                this.email.default = "";
                this.status.default = 3;
            } catch (error) {
                console.log(error);
            }
        },
        async updateUserModif() {
            try {
                let payload = {
                    user: {
                        username: this.username.default,
                        email: this.email.default,
                        status: this.status.default,
                    }
                };
                console.log("user info = ", this.id.default)
                console.log('http://localhost:4000/api/users/' + this.id.default)

                let res = await axios.put('http://localhost:4000/api/users/' + this.id.default, payload);

                let data = res.data;
                console.log(data);
                this.id.default = 0;
                this.username.default = "";
                this.email.default = "";
                this.status.default = 3;
            } catch (error) {
                console.log(error);
            }
        },
    }
}
</script>
<script setup lang="ts">
import axios from 'axios';
import { ref } from "vue";
let input = ref("");

function filteredList(users: Array<any>) {
    return users.filter((user) =>
        user.username.toLowerCase().includes(input.value.toLowerCase())
    );
}
</script>

<template>
    <div>AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA</div>
    <div class="absolute top-0 left-100" >
    <label for="my-modal" class="btn">Create a new user</label>
    <input type="checkbox" id="my-modal" class="modal-toggle" />
    <div class="modal">
        <div class="modal-box relative" for="">
            <label for="my-modal" class="btn btn-sm btn-circle absolute right-2 top-2">✕</label>
            <p>e-mail :</p>
            <input v-model="email.default" placeholder="exemple@ex.com" />
            <p>username :</p>
            <input v-model="username.default" placeholder="username" />
            <p>status :</p>
            <div class="collapse">
                <input type="checkbox" class="peer" />
                <div class="collapse collapse-title collapse-arrow peer-checked:text-secondary-content">
                    {{ statusName.default }}
                </div>
                <div class="collapse-content peer-checked:text-secondary-content ">
                    <div class="btn btn-xs sm:btn-sm md:btn-md lg:btn-md" v-on:click="setStatus('Employee')">Employee</div>
                    <div class="btn btn-xs sm:btn-sm md:btn-md lg:btn-md" v-on:click="setStatus('Manager')">Manager</div>
                    <div class="btn btn-xs sm:btn-sm md:btn-md lg:btn-md" v-on:click="setStatus('General manager')">General manager</div>
                </div>
            </div>
            <div class="modal-action">
                <label for="my-modal" class="btn" v-on:click="resetUserModif()">cancel</label>
                <label for="my-modal" class="btn" v-on:click="CreateUser()">create user</label>
            </div>
        </div>
    </div>
    <label for="my-modal-2" class="btn" v-on:click="GetUsers()">Modify a user</label>
    <input type="checkbox" id="my-modal-2" class="modal-toggle" />
    <div class="modal">
        <div class="modal-box relative" for="">
            <label for="my-modal-2" class="btn btn-sm btn-circle absolute right-2 top-2">✕</label>

            <input type="text" v-model="input" placeholder="Search user..." />
            <div class="btn btn-xs sm:btn-sm md:btn-md lg:btn-md" v-for="user in filteredList(users)"
                v-on:click="setUserModif(user)" :key="user">
                <p>{{ user.username }}</p>
            </div>
            <div class="btn btn-xs sm:btn-sm md:btn-md lg:btn-md btn-disabled"
                v-if="input && !filteredList(users).length">
                <p>No results found</p>
            </div>

            <p>e-mail</p>
            <input v-model="email.default" placeholder="exemple@ex.com" />
            <p>username</p>
            <input v-model="username.default" placeholder="username" />
            <p>status</p>
            <div class="collapse">
                <input type="checkbox" class="peer" />
                <div class="collapse collapse-title collapse-arrow peer-checked:text-secondary-content">
                    {{ statusName.default }}
                </div>
                <div class="collapse-content peer-checked:text-secondary-content ">
                    <div class="btn btn-xs sm:btn-sm md:btn-md lg:btn-md" v-on:click="setStatus('Employee')">Employee</div>
                    <div class="btn btn-xs sm:btn-sm md:btn-md lg:btn-md" v-on:click="setStatus('Manager')">Manager</div>
                    <div class="btn btn-xs sm:btn-sm md:btn-md lg:btn-md" v-on:click="setStatus('General manager')">General manager</div>
                </div>
            </div>
            <div class="modal-action">
                <label for="my-modal-2" class="btn" v-on:click="resetUserModif()">cancel</label>
                <label for="my-modal-2" class="btn" v-on:click="updateUserModif()">update informations</label>
            </div>
        </div>
    </div>
    <label for="my-modal3" class="btn" v-on:click="GetUsers()">Delete a user</label>
    <input type="checkbox" id="my-modal3" class="modal-toggle" />
    <div class="modal">
        <div class="modal-box relative" for="">
            <input type="text" v-model="input" placeholder="Search user..." />
            <div class="btn btn-xs sm:btn-sm md:btn-md lg:btn-md" v-for="user in filteredList(users)"
                v-on:click="DeleteUser(user)" :key="user">
                <p>{{ user.username }}</p>
            </div>
            <div class="btn btn-xs sm:btn-sm md:btn-md lg:btn-md btn-disabled"
                v-if="input && !filteredList(users).length">
                <p>No results found</p>
            </div>
            <div class="modal-action">
                <label for="my-modal3" class="btn" v-on:click="resetUserModif()">cancel</label>
                <label for="my-modal3" class="btn" v-on:click="CreateUser()">create user</label>
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