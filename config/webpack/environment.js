const { environment } = require('@rails/webpacker')
// jquery popper query dependancies should understand.
// so added some code here
const Webpack = require("webpack")
environment.plugins.append("Provide", new Webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
}))

module.exports = environment
