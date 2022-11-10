/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    borderWidth: {
      DEFAULT: '1px',
      '0': '0',
      '2': '2px',
      '3': '3px',
      '4': '4px',
      '6': '6px',
      '8': '8px',
    },
    extend: {
      colors: {
        'yellow' : '#EBFF00',
        'gray' : '#3B3B40',
        'lightgray' : '#878788'
      },
    },
  },
  plugins: [require("daisyui")],
}
