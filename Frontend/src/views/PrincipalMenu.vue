<script lang="ts">
export default {
    data() {
        return {
            screentype: {
                type: Number,
                default: 1
            },
        }
    },
    methods: {
        menuSelection(value: number) {
            console.log("value is =", value)
            this.screentype.default = value;
        }
    }
}
</script>
<script lang="ts" setup>
import Dashboard from "../components/menus/DashboardMenu.vue"
import SettingsMenu from "../components/menus/SettingsMenu.vue"
import InfoMenu from "../components/menus/InfoMenu.vue"
import LoginMenu from "../components/menus/LoginMenu.vue"
</script>

<template>
    <LoginMenu @menuSelection="menuSelection" v-if="screentype.default==0"></LoginMenu>
    <Dashboard @menuSelection="menuSelection" v-if="screentype.default == 1" :userType="'general_manager'"></Dashboard>
    <!-- userType = employee - manager - general_manager -->
    <SettingsMenu @menuSelection="menuSelection" v-if="screentype.default == 2"></SettingsMenu>
    <InfoMenu @menuSelection="menuSelection" v-if="screentype.default == 3"></InfoMenu>

</template>
