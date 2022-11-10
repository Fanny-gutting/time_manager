<script lang="ts">
export default {
    data() {
        return {
        }
    },
    methods: {
        // clockInOut(clocked) {
        //     return !clocked;
        // },
    }
}
</script>

<template>
    <div></div>
    <!-- <button v-if="clocked === false" v-on:click="clocked = clockInOut(clocked)">clock in</button>
    <button v-if="clocked === true" v-on:click="clocked = clockInOut(clocked)">clock out</button> -->
</template>

<style scoped>
button {
    height: 500px;
    width: 500px;
    background-color: brown;
    border-radius: 50%;
    font-size: 100px;
}
</style>