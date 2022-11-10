<script setup lang="ts">
import PrincipalMenu from './views/PrincipalMenu.vue'
</script>

<template>
    <header>
        <PrincipalMenu></PrincipalMenu>
    </header>

</template>

<!-- <template>
    <button v-on:click="getData()">try this </button>
    <div>
        <ul v-for="post in posts" v-bind:key="post.id">
            <li>{{ post.id }}</li>
            <p>{{ post.car }}</p>
        </ul>
    </div>
</template>

<script>
export default {
    data() {
        return {
            posts: [],
        };
    },

    methods: {
        async getData() {
            try {
                let response = await fetch("https://myfakeapi.com/api/cars/1");
                this.posts = await response.json();
            } catch (error) {
                console.log(error);
            }
        },
    },

    // created() {
    //     this.getData();
    // },
};
</script> -->