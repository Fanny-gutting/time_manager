<script lang="ts">
export default {
    data() {
        return {
            screentype: {
                type: Number,
                default: 0
            },
            UserType: {
                type: String,
                default: ""
            },
            User: {
                id: {
                    type: Number,
                    default: 0
                },
                email: {
                    type: String,
                    default: ""
                },
                username: {
                    type: String,
                    default: ""
                },
                status: {
                    type: Number,
                    default: 0
                }
            },
        }
    },
    methods: {
        login(value: number, UserId: number, UserEmail: string, UserUsername: string, UserStatus: number) {
            console.log("value is =", value)
            this.screentype.default = value;
            this.User.id.default = UserId;
            this.User.email.default = UserEmail;
            this.User.username.default = UserUsername;
            this.User.status.default = UserStatus;
            console.log("userstatus = ", UserStatus)
            if (UserStatus == 3) {
                this.UserType.default = "employee";
            }
            else if (UserStatus == 2) {
                this.UserType.default = "manager";
            }
            else if (UserStatus == 1) {
                this.UserType.default = "general manager";
            }
        },
        menuSelection(value: number, UserId: number, UserEmail: string, UserUsername: string, UserStatus: number ) {
            console.log("value is =", value)
            this.User.id.default = UserId;
            this.User.username.default = UserUsername;
            this.User.email.default = UserEmail;
            this.User.status.default = UserStatus;
            this.screentype.default = value;
        },
    }
}
</script>
<script lang="ts" setup>
import Dashboard from "../components/menus/DashboardLateralMenu.vue"
import SettingsMenu from "../components/menus/SettingsMenu.vue"
import InfoMenu from "../components/menus/InfoMenu.vue"
import LoginMenu from "../components/menus/LoginMenu.vue"
</script>

<template>
    <LoginMenu @login="login" v-if="screentype.default==0"></LoginMenu>
    <Dashboard @menuSelection="menuSelection" v-if="screentype.default == 1" :userType="UserType.default"
        :UserId="User.id.default" :UserEmail="User.email.default" :UserUsername="User.username.default"
        :UserStatus="User.status.default" />
    <!-- userType = employee - manager - general_manager -->
    <SettingsMenu @menuSelection="menuSelection" v-if="screentype.default == 2" :userType="UserType.default"
        :UserId="User.id.default" :UserEmail="User.email.default" :UserUsername="User.username.default"
        :UserStatus="User.status.default" />
    <InfoMenu @menuSelection="menuSelection" v-if="screentype.default == 3" :userType="UserType.default"
        :UserId="User.id.default" :UserEmail="User.email.default" :UserUsername="User.username.default"
        :UserStatus="User.status.default" />
</template>
