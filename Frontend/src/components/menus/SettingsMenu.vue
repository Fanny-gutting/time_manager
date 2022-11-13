<script lang="ts">
export default {
    props: {
        userType: String,
        UserId: Number,
        UserEmail: String,
        UserUsername: String,
        UserStatus: Number
    },
    data() {
        return {
            users: [] as { id: Number, username: String, email: String, status: Number }[],
            search: {
                type: String,
                default: "",
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
    emits: ['menuSelection'],
    methods: {
        DashboardMenu() {
            console.log("settings");
            this.$emit('menuSelection', "1", this.UserId, this.email.default, this.username.default, this.UserStatus);
        },
        async GetUsers() {
            try {
                console.log("in the api call")
                axios.get('http://localhost:4000/api/users').then(resp => {
                    console.log("data is = ", resp.data.data);
                    this.users = resp.data.data;
                    for (var i = 0; i < this.users.length; i++)
                        if (this.users[i].id == this.UserId) {
                            this.email.default = this.users[i].email.toString();
                            this.username.default = this.users[i].username.toString();
                            console.log("this.users[i].email = ", this.users[i].email)
                            console.log("this.users[i].username = ", this.users[i].username);
                        }
                    return this.users;
                });
            } catch (error) {
                console.log(error);
            }
        },
        resetUserModif() {
            if (this.UserEmail && this.UserUsername) {
                this.email.default = this.UserEmail;
                this.username.default = this.UserUsername;
            }
            this.updateUserModif();
        },
        async DeleteUser() {
            try {
                let res = await axios.delete('http://localhost:4000/api/users/' + this.UserId);

                let data = res.data;
                console.log(data);
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
                    }
                };
                console.log('http://localhost:4000/api/users/' + this.UserId)

                let res = await axios.put('http://localhost:4000/api/users/' + this.UserId, payload);
                let data = res.data;
                console.log(data);
                this.GetUsers();
            } catch (error) {
                console.log(error);
            }
        },
    }
}
</script>
<script setup lang="ts">
import axios from 'axios';
</script>

<template>
    <div class="absolute top-0 left-100">
        <button v-on:click="DashboardMenu()">back to dashboard</button>
        <div class="collapse">
            <input type="checkbox" class="peer" v-on:click="GetUsers()"/>
            <label class=" btn collapse collapse-title collapse-arrow peer-checked:text-secondary-content">
                account settings
            </label>
            <div class="collapse-content peer-checked:text-secondary-content ">
                <p>e-mail</p>
                <input v-model="email.default" placeholder="exemple@ex.com" />
                <p>username</p>
                <input v-model="username.default" placeholder="username" />
                <label class="btn" v-on:click="resetUserModif()">cancel</label>
                <label class="btn" v-on:click="updateUserModif(), GetUsers()">update informations</label>
            </div>
        </div>

        <label class="btn" v-on:click="DeleteUser()">delete user</label>

    </div>
</template>

<style scoped>
input {
    color: #111;
}
</style>