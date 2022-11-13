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
        DashboardMenu() {
            console.log("info");
            this.$emit('menuSelection', "1", this.UserId, this.UserEmail, this.UserUsername, this.UserStatus);
        },
    }
}
</script>

<template>
    <button v-on:click="DashboardMenu()">back to dashboard</button>

    <p>username :</p>
    <p>{{ UserUsername }}</p>
    <p>e-mail :</p>
    <p>{{ UserEmail }}</p>
    <p>Role :</p>
    <p>{{ userType }}</p>

</template>

<style scoped>
input {
    color: #111;
}
</style>