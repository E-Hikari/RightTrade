/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './src/**/*.tsx',
    './index.html'
  ],
  theme: {
    extend: {
      colors: {
        background: '#000923'
      },

      fontFamily: {
        'poppins': ['Poppins', 'sans-serif'],
        'montserrat': ['Montserrat', 'sans-serif']
      },

      gridTemplateRows:{
        7: 'repeat(7, minmax(0, 1fr))'
      }
    },
  },
  plugins: [],
}
