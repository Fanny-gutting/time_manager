import { defineComponent, h } from 'vue'

import { PolarArea } from 'vue-chartjs'
import {
    Chart as ChartJS,
    Title,
    Tooltip,
    Legend,
    ArcElement,
    RadialLinearScale,
} from 'chart.js'
import type { PropType } from 'vue'
import type { Plugin } from 'chart.js'

ChartJS.register(Title, Tooltip, Legend, ArcElement, RadialLinearScale)

export default defineComponent({
    name: 'PolarAreaChart',
    components: {
        PolarArea
    },
    props: {
        chartId: {
            type: String,
            default: 'polar-chart'
        },
        width: {
            type: Number,
            default: 400
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
            type: Array as PropType<Plugin<'polarArea'>[]>,
            default: () => []
        }
    },
    setup(props) {
        const chartData = {
            labels: [
                'Monday',
                'Tuesday',
                'Wednesday',
                'Thursday',
                'Friday',
                'Saturday',
                'Sunday',

            ],
            datasets: [
                {
                    label: 'Hours Worked',
                    backgroundColor: 'rgba(179,181,198,555)',
                    pointBackgroundColor: 'rgba(179,181,198,555)',
                    pointBorderColor: '#fff',
                    pointHoverBackgroundColor: '#fff',
                    pointHoverBorderColor: 'rgba(179,181,198,555)',
                    data: [8, 6, 10, 5, 8, 2, 1]
                },
                {
                    label: 'Hours required',
                    backgroundColor: 'rgba(255,99,132,555)',
                    pointBackgroundColor: 'rgba(255,99,132,555)',
                    pointBorderColor: '#fff',
                    pointHoverBackgroundColor: '#fff',
                    pointHoverBorderColor: 'rgba(255,99,132,555)',
                    data: [7, 7, 7, 7, 7, 0, 0]
                }
            ]
        }

        const chartOptions = {
            responsive: true,
            maintainAspectRatio: false
        }

        return () =>
            h(PolarArea, {
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
