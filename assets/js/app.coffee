window.app = {
  models: {}
  collections: {}
  views: {}
  routers: {}
}

class app.models.Note extends Backbone.Model

  defaults:
    title: 'Blank note'
    content: '...'


class app.collections.Notes extends Backbone.Collection

  model: app.models.Note
  url: '/notes'


class app.views.JournalCreate extends Backbone.View

  id: 'journal-create'

  initialize: ->
    

  render: ->


class app.views.NoteWall extends Backbone.View

  id: 'note-wall'

  initialize: ->
    #src = $('#note-wall-template').html()
    #@template = Handlebars.compile(src)
    # bind to main note collection
    app.notes.on('add', @addOne, @)
  
  render: ->
    return @

  addOne: (note) ->
    mini_note = new app.views.MiniNote model: note
    @$el.append mini_note.render().el


class app.views.MiniNote extends Backbone.View

  className: 'mini-note'

  initialize: ->
    src = $('#mini-note-template').html()
    @template = Handlebars.compile(src)

  render: ->
    @$el.html @template({
      title: @model.get('title')
      content: @model.get('content')
    })
    return @


class app.routers.Main extends Backbone.Router

  routes:
    '': 'journal_create'

  journal_create: ->
    #view = new app.views.JournalCreate()
    #$('#main').append view.render().el


$(document).ready ->

  app.router = new app.routers.Main()

  app.notes = new app.collections.Notes()

  wall = new app.views.NoteWall()
  $('#main').append wall.render().el

  app.notes.create title: 'test', content: 'lorem ipsum larum dipsum'
  app.notes.create title: 'test', content: 'lorem ipsum larum dipsum'
  app.notes.create title: 'test', content: 'lorem ipsum larum dipsum'
  app.notes.create title: 'test', content: 'lorem ipsum larum dipsum'
  app.notes.create title: 'test', content: 'lorem ipsum larum dipsum'

  Backbone.history.start({ pushState: true })