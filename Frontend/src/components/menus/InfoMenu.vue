<script lang="ts">
export default {
    emits: ['menuSelection'],

    methods: {
        DashboardMenu() {
            console.log("info");
            this.$emit('menuSelection', "1");
        },
    }
}
</script>

<template>
    <button v-on:click="DashboardMenu()">back to dashboard</button>

    <div>your name is david</div>
    <div>your age is 45</div>

</template>

<style scoped>
input{
    color: #111;
}
</style>