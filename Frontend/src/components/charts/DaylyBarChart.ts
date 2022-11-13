import { defineComponent, h } from 'vue'
import type { PropType } from 'vue'
import { Bar } from 'vue-chartjs'
import {
    Chart as ChartJS,
    Title,
    Tooltip,
    Legend,
    BarElement,
    CategoryScale,
    LinearScale,
} from 'chart.js'
import type { Plugin } from 'chart.js'


ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)

export default defineComponent({
    name: 'BarChart',
    components: {
        Bar
    },
    props: {
        chartId: {
            type: String,
            default: 'bar-chart'
        },
        width: {
            type: Number,
            default: 200
        },
        height: {
            type: Number,
            default: 400
        },
        cssClasses: {
            default: '',
            type: String
        },
        styles: {
            type: Object as PropType<Partial<CSSStyleDeclaration>>,
            default: () => { }
        },
        plugins: {
            type: Array as PropType<Plugin<'bar'>[]>,
            default: () => []
        }
    },
    setup(props) {
        const chartData = {
            labels: [
                '01h',
                '02h',
                '03h',
                '04h',
                '05h',
                '06h',
                '07h',
                '08h',
                '09h',
                '10h',
                '11h',
                '12h',
                '13h',
                '14h',
                '15h',
                '16h',
                '17h',
                '18h',
                '19h',
                '20h',
                '21h',
                '22h',
                '23h',
                '00h',
            ],
            datasets: [
                {
                    label: 'Worked hours',
                    backgroundColor: '#f87979',
                    data: [0, 0, 0, 0, 0, 0, 0.4, 1, 1, 1, 1, 0.1, 0, 0, 1, 1, 1, 1, 0.5, 0, 0, 1, 1, 1]
                }
            ]
        }

        const chartOptions = {
            responsive: true,
            maintainAspectRatio: false
        }

        return () =>
            h(Bar, {
                chartData,
                chartOptions,
                chartId: props.chartId,
                width: props.width,
                height: props.height,
                cssClasses: props.cssClasses,
                styles: props.styles,
                plugins: props.plugins
            })
    }
})