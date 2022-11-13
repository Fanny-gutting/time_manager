<script lang="ts">
export default {
    data() {
        return {
            clocked: {
                type: Boolean,
                default: true,
            }
        }
    },
    methods: {
        getDate() {
            var date = new Date()
            var dateFormated = date.getFullYear().toString() + "-" + (date.getMonth() + 1).toString() + "-" + date.getUTCDate().toString() + " " +
                (date.getHours().toString().length > 1 ? date.getHours().toString() : '0' + date.getHours().toString()) + ":" +
                (date.getMinutes().toString().length > 1 ? date.getMinutes().toString() : '0' + date.getMinutes().toString()) + ":" +
                (date.getSeconds().toString().length > 1 ? date.getSeconds().toString() : '0' + date.getSeconds().toString())
            return (dateFormated.toString())
        },
        async ClockInOut() {
            try {
                var date = this.getDate();
                var userId = localStorage.getItem('userId')
                console.log("date = " + date)
                console.log("userId = " + userId)

                let payload = {
                    clock: {
                        time: date,
                        status: this.clocked.default,
                    }
                };
                let res = await axios.post('http://localhost:4000/api/clocks/' + userId, payload);
                let data = res.data;
                console.log(data);

                this.clocked.default = !this.clocked.default;
            } catch (error) {
                console.log(error);
            }
        },

    }
}
</script>
<script lang="ts" setup>
import axios from 'axios';
import { ref, onBeforeUnmount } from "vue";

const useCurrentTime = () => {
    const currentTime = ref(new Date());
    const updateCurrentTime = () => {
        currentTime.value = new Date();
    };
    const updateTimeInterval = setInterval(updateCurrentTime, 1000);
    onBeforeUnmount(() => {
        clearInterval(updateTimeInterval);
    });
    return {
        currentTime,
    };
};
const { currentTime } = useCurrentTime();
console.log(currentTime.value);

</script>

<template>
    <div class="flex justify-start bg-base-200">
        <div class="hero-content w-2/4 text-center">
            <div class="w-5/6 rounded drop-shadow-xl" style="background-color: rgba(255, 255, 255, 0.88)">
                <div>
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2"
                        stroke="currentColor" class="top-5 -right-35 ml-10 w-20 h-20">
                        <path stroke-linecap="round" stroke-linejoin="round"
                            d="M12 6v6h4.5m4.5 0a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                    <h1 class="-mt-11 ml-5 text-5xl font-bold">Time Clock</h1>
                </div>
                <h2 class="text-3xl top-5">{{ currentTime.getUTCDate() }}/{{ (currentTime.getMonth() + 1) }}/{{
                        currentTime.getFullYear()
                }}</h2>
                <div class="grid flex justify-center grid-flow-col gap-5 text-center auto-cols-max m-10">
                    <div class="flex flex-col p-2 bg-neutral bg-lightgray text-black rounded-box text-neutral-content">
                        <span class="countdown font-mono text-3xl">
                            {{ (currentTime.getHours().toString().length > 1 ? currentTime.getHours().toString() : '0' +
                                    currentTime.getHours().toString())
                            }}
                        </span>
                        hours
                    </div>
                    <div class="flex flex-col p-2 bg-neutral bg-lightgray text-black rounded-box text-neutral-content">
                        <span class="countdown font-mono text-3xl">
                            {{ (currentTime.getMinutes().toString().length > 1 ? currentTime.getMinutes().toString() :
                                    '0' + currentTime.getMinutes().toString())
                            }}
                        </span>
                        min
                    </div>
                    <div class="flex flex-col p-2 bg-neutral bg-lightgray text-black rounded-box text-neutral-content">
                        <span class="countdown font-mono text-3xl">
                            {{ (currentTime.getSeconds().toString().length > 1 ? currentTime.getSeconds().toString() :
                                    '0' + currentTime.getSeconds().toString())
                            }}
                        </span>
                        sec
                    </div>
                </div>
                <label
                    class="m-5 mb-20 btn btn-wide hover:text-yellow text-lg drop-shadow-lg focus:bg-yellow focus:text-white"
                    v-if="clocked.default === true" v-on:click="ClockInOut()">Clock in</label>
                <label
                    class="m-5 mb-20 btn btn-wide hover:text-yellow text-lg drop-shadow-lg focus:bg-yellow focus:text-white"
                    v-if="clocked.default === false" v-on:click="ClockInOut()">Clock out</label>
            </div>
        </div>
    </div>
</template>

<style scoped>

</style>