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
            password: {
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
    emits: ['login'],

    methods: {
        async getUserInfo() {
            try {
                let check = false;
                console.log("in the api call")
                axios.get('http://localhost:4000/api/users').then(resp => {
                    console.log("data is = ", resp.data.data);
                    this.users = resp.data.data;
                    for (let i = 0; i < this.users.length; i++)
                        if (this.users[i].username == this.username.default) {
                            console.log("login");
                            check = true;
                            this.$emit('login', "1", this.users[i].id, this.users[i].email, this.users[i].username, this.users[i].status);
                            localStorage.setItem('userId', this.users[i].id.toString())
                        }
                    if (!check) {
                        console.log("this.users fail = ", this.users);
                        alert("Error : email or password is incorrect")
                    }
                });
            } catch (error) {
                console.log(error);
            }
        },

        async logIn() {
            console.log("username = ", this.username.default)
            console.log("password = ", this.password.default)
            try {
                // username: "admin",
                // password: "password",
                let payload = {
                    username: this.username.default,
                    password: this.password.default
                };
                let res = await axios.post('http://localhost:4000/api/users/sign_in', payload);
                let data = res.data;
                localStorage.setItem('token', data.data.token)
                let token = localStorage.getItem('token')
                console.log("token = ", token)
                if (token) {
                    axios.defaults.headers.common['Authorization'] = 'Bearer ' + token;
                }
                this.getUserInfo();
            } catch (error) {
                alert("Error : email or password is incorrect")
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
    <div class="bg">
        <img src="../../assets/images/gotham.jpg" />
        <div class="content">
            <div class="title-content">
                <img class="logo" src="../../assets/images/logo-batman.png" />
                <h1>LOGIN</h1>
            </div>
            <div class="text-content">
                <p class="text-input">Username</p>
                <div id="email">
                    <input v-model="username.default" type="text" placeholder="Type your Email"
                        class="input hover:border-yellow input-ghost w-full max-w-xs" />
                </div>
                <p class="text-input">Password</p>
                <div id="password">
                    <input v-model="password.default" type="password" placeholder="Type your password"
                        class="input hover:border-yellow input-ghost w-full max-w-xs"/>
                </div>
            </div>
            <div class="login">
                <button
                    class="btn btn-outline bg-gray text-white shadow button hover:border-yellow hover:shadow-lg hover:bg-yellow hover:text-black"
                    v-on:click="logIn()">Login</button>
            </div>
            <div class="other">
                <div id="grid-text">
                    <div class="line"> </div>
                    <p id="text">OR</p>
                    <div class="line"> </div>
                </div>
                <div id="grid-img">
                    <img id="google" src="../../assets/images/google.png">
                    <img id="fb" src="../../assets/images/fb.png">
                    <img id="linkedin" src="../../assets/images/linkedin.png">
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.content {
    background-color: rgba(255, 255, 255, 0.88);
    box-shadow: 0px 0px 23px 7px black;
    top: 7%;
    left: 32.5%;
    height: 85%;
    width: 35%;
    position: fixed;
    padding-top: 0;
    border-radius: 5%;
}

.title-content {
    height: 30%;
    width: 100%;
}

h1 {
    top: -47%;
    font-size: 50px;
    font-weight: bolder;
    color: yellow;
    text-align: center;
}

.logo {
    height: 70%;
    width: 70%;
    left: 15%;
    top: 10%;
}

.bg {
    height: 100vh;
    width: 100vw;
    position: fixed;
    background-size: cover;
    z-index: 1;
    /* top: 0;
    left: 0; */
    padding-top: 0px;
    filter: brightness(100%);
}

.text-content {
    height: 30%;
    width: 100%;
}

.login {
    height: 15%;
    width: 100%;
}

.text-input {
    left: 10%;
    margin: 10px;
    margin-top: 20px;
    font-size: 20px;
    font-weight: bolder;
}

.other {
    margin-top: 20px;
    height: 25%;
    width: 100%;
}

#grid-img {
    display: grid;
    width: 100%;
    left: 27%;
    grid-template-columns: repeat(auto-fill, minmax(90px, 1fr));
    grid-gap: 10px;
    padding: 20px;
    margin-top: 10px
}

#grid-text {
    display: grid;
    width: 100%;
    left: 20%;
    grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
    grid-gap: 5px;
    margin-top: 10px
}

#text {
    text-align: center;
    font-size: 20px;
    font-weight: bolder;
}

.input {
    left: 10%;
}

.line {
    background-color: grey;
    height: 3px;
    width: 100%;
}

button {
    height: 60%;
    width: 35%;
    left: 33%;
    font-size: 30px;
    font-weight: bolder;
}
</style>