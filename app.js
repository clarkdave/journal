var express = require('express');

var app = express.createServer();

app.configure(function() {
  app.use( require('connect-assets')() );
  app.set('view engine', 'jade');
  app.set('view options', { pretty: true });
});

app.get('/', function(req, res) {
  res.render('index');
});

app.listen(3000);