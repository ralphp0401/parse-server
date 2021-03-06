// Example express application adding the parse-server module to expose Parse
// compatible API routes.


var express = require('express');
var app = express();
var ParseServer = require('parse-server').ParseServer;
var ParseDashboard = require('parse-dashboard');
var path = require('path');

var options = { allowInsecureHTTP: true };

if (app.get('env') == 'development') {
  require('dotenv').config();
}
var databaseUri = process.env.DATABASE_URI || process.env.MONGODB_URI;

if (!databaseUri) {
  console.log('DATABASE_URI not specified, falling back to localhost.');
}

var api = new ParseServer({
  databaseURI: databaseUri || 'mongodb://localhost:27017/dev',
  cloud: process.env.CLOUD_CODE_MAIN || __dirname + '/cloud/main.js',
  appId: process.env.APP_ID || 'myAppId',
  masterKey: process.env.MASTER_KEY || 'myMasterKey',
  javascriptKey: process.env.JAVASCRIPT_KEY || 'myJavascriptKey',
  restAPIKey: process.env.REST_API_KEY || 'myRestApiKey',
  clientKey: process.env.CLIENT_KEY || 'myClientKey',
  serverURL: process.env.SERVER_URL || 'http://localhost:1337/parse',  // Don't forget to change to https if needed
  liveQuery: {
    classNames: ["Posts", "Comments"] // List of classes to support for query subscriptions
  }
});
// Client-keys like the javascript key or the .NET key are not necessary with parse-server
// If you wish you require them, you can set them as options in the initialization above:
// javascriptKey, restAPIKey, dotNetKey, clientKey

var dashboard = new ParseDashboard({
	"apps": [
    {
      "serverURL": process.env.SERVER_URL || 'http://localhost:1337/parse',
      "appId": process.env.APP_ID || 'myAppId',
      "masterKey": process.env.MASTER_KEY || 'myMasterKey',
      "appName": "Evolussion"
    }
  ],
  "users": [
    {
      "user": process.env.ADMIN_USER || 'admin',
      "pass": process.env.ADMIN_PASSWORD || "password"
    }
  ],
  "useEncryptedPasswords": false
}, options);

// Serve static assets from the /public folder
app.use('/public', express.static(path.join(__dirname, '/public')));

// Serve the Parse API on the /parse URL prefix
var mountPath = process.env.PARSE_MOUNT || '/parse';
app.use(mountPath, api);

// Parse Server plays nicely with the rest of your web routes
app.get('/', function(req, res) {
  res.redirect('/dashboard');
});

// make the Parse Dashboard available at /dashboard
app.use('/dashboard', dashboard);

// // There will be a test page available on the /test path of your server url
// // Remove this before launching your app
// app.get('/test', function(req, res) {
//   res.sendFile(path.join(__dirname, '/public/test.html'));
// });

var port = process.env.PORT || 1337;
var httpServer = require('http').createServer(app);
httpServer.listen(port, function() {
    console.log('Parse server URL: ' + process.env.SERVER_URL);
    console.log('parse-server-example running on port ' + port + '.');
    
});

// This will enable the Live Query real-time server
ParseServer.createLiveQueryServer(httpServer);
