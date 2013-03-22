#= require "vendor_all"
#= require_directory "./templates/"

class TripItem extends Backbone.View
  className: 'gradeX'
  tagName: 'tr'
  events:
    "click .see" : "onClickSee"

  onClickSee: ->
    alert "Hisciste click en ver"

  render: =>
    @$el.html JST['templates/trips_list_item']()
    @$el

class TripsList extends Backbone.View

  className: "widget-box trip-list"

  render: =>
    @$el.html JST['templates/trips_list']()
    @loadList()
    @$el

  loadList: ->
    @$("tbody").html ''
    for num in [1..10]
      item = new TripItem()
      @$("tbody").append item.$el
      item.render()



class Applicaction extends Backbone.View

  initialize: ->
    list = new TripsList()
    console.log list
    @$(".container-fluid").append list.$el
    list.render()


appOnLoad = ->
  App = new Applicaction el: $("body")[0]


  window.App = App
window.appOnLoad = appOnLoad