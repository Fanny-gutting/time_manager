import { createRouter, createWebHistory } from 'vue-router'
import PrincipalMenu from '../views/PrincipalMenu.vue'

const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL),
    routes: [
        {
            path: '/',
            // component: PrincipalMenu
            component: () => import('../components/WorkingTimes.vue')

        },
        {
            path: '/manageAccountsMenu',
            component: () => import('../components/menus/ManageAccountsMenu.vue')
        },
        {
            path: '/manageTeamsMenu',
            component: () => import('../components/menus/ManageTeamsMenu.vue')
        },
        {
            path: '/clocking',
            component: () => import('../components/menus/ClockingMenu.vue')
        },
        {
            path: '/workingtimes',
            component: () => import('../components/WorkingTimes.vue')
        },
        {
            path: '/workingtime',
            component: () => import('../components/WorkingTime.vue')
        },
        {
            path: '/dashboard',
            component: () => import('../components/PersonalDashboard.vue')
        },
    ]
})

export default router
