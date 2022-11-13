<script lang="ts">
export default {
    data() {
        return {
            WeeklyChart: {
                type: Boolean,
                default: true,
            }
        }
    },
    methods: {
        SwitchChart() {
            this.WeeklyChart.default = !this.WeeklyChart.default;
        }
    }
}
</script>
<script lang="ts" setup>
import WeeklyBarChart from './charts/WeeklyBarChart';
import DaylyBarChart from './charts/DaylyBarChart';
import WeeklyDonutChart from './charts/WeeklyDonutChart';
import WeeklyPoleAreaChart from './charts/WeeklyPoleAreaChart';
</script>


<template>
    <WeeklyBarChart v-if="WeeklyChart.default"></WeeklyBarChart>
    <DaylyBarChart v-if="!WeeklyChart.default"></DaylyBarChart>
    <label class="btn" v-if="WeeklyChart.default" v-on:click="SwitchChart()">switch to dayly hours</label>
    <label class="btn" v-if="!WeeklyChart.default" v-on:click="SwitchChart()">switch to weekly hours</label>
    <WeeklyDonutChart></WeeklyDonutChart>
    <WeeklyPoleAreaChart></WeeklyPoleAreaChart>

</template>

<style>

</style>
