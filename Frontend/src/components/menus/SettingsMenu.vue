<script lang="ts">
export default {
    emits: ['menuSelection'],

    methods: {
        DashboardMenu() {
            console.log("settings");
            this.$emit('menuSelection', "1");
        },
    }
}
</script>

<template>
    <button v-on:click="DashboardMenu()">back to dashboard</button>

    <p>e-mail</p>
    <input placeholder="exemple@ex.com" />
    <p>name</p>
    <input />
    <p>other</p>
    <input />

</template>

<style scoped>
input{
    color: #111;
}
</style>