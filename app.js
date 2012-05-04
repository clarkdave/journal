var express = require('express');
var mongoose = require('mongoose');

mongoose.connect('mongodb://localhost/journal_dev');

var Schema = mongoose.Schema, ObjectId = Schema.ObjectId;

var Note = mongoose.model('Note', new Schema({
  title: String,
  content: String,
  tags: [String]
}));

var app = express.createServer();

app.configure(function() {
  app.use( require('connect-assets')() );
  app.use( express.bodyParser() );
  app.set('view engine', 'jade');
  app.set('view options', { pretty: true });
});

app.get('/', function(req, res) {
  res.render('index');
});

app.get('/notes', function(req, res) {
  Note.find({}, function (err, docs) {
    if (err) return res.send(500);
    res.contentType('application/json');
    res.send(docs);
  });
});

app.post('/notes', function(req, res) {

  body = req.body;

  var new_note = new Note();
  new_note.title = body.title;
  new_note.content = body.content;

  new_note.save(function(err) {
    if (err == null) {
      console.log('Created new note: ' + new_note);
      return res.send(201);
    } else {
      console.log('! Could not create note: ' + body);
      return res.send(422);
    }
  });
});

app.listen(3000);