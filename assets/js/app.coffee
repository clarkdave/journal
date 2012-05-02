window.app = {
  models: {}
  collections: {}
  views: {}
  routers: {}
}

class app.views.JournalCreate extends Backbone.View

  id: 'journal-create'

  initialize: ->
    

  render: ->


class app.routers.Main extends Backbone.Router

  routes:
    '': 'journal_create'

  journal_create: ->
    view = new app.views.JournalCreate()
    $('#main').append view.render().el


$(document).ready ->

  app.router = new app.routers.Main()

  Backbone.history.start({ pushState: true })