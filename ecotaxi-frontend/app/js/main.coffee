#= require 'vendor_all'
#= require 'models'
#= require 'widgets'
#= require_directory './templates/'

class Applicaction extends Backbone.View

  initialize: ->
    list = new TripsList collection: new Trips()
    console.log list
    @render()
    @$(".container").append list.$el
    list.render()

  render: =>
    @$el.html JST['templates/application']()
    @$el

appOnLoad = ->
  App = new Applicaction el: $("body")[0]


  window.App = App
window.appOnLoad = appOnLoad