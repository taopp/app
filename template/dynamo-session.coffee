express = require 'express'
DynamoDBStore = require('connect-dynamodb') express
app = express()

module.exports = (options, routes) ->
    {favicon, hostname, awsConfig, secretKey, public} = options
    isDev = app.get('env') is 'development'
    app.set 'trust proxy', true
    app.use (req, res, next) ->
        unless req.host is hostname
            res.redirect "http://kkssss.com/warning?action=csrf&dest=#{hostname}&src=#{req.host}"
        else
            next()
    app.use express.favicon(favicon))
    app.use express.logger('dev') if isDev
    app.use express.bodyParser()
    app.use express.cookieParser()
    app.use express.session(
        key: hostname
        store: new DynamoDBStore(AWSConfigPath: awsConfig), reapInterval: -1)
        cookie: {maxAge: 365 * 24 * 60 * 60 * 1000}
        secret: secretKey)
    app.use app.router
    app.use express.static(public)

    app.use express.errorHandler() if isDev

    routes app
    app
