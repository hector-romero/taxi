#= require 'widgets'
#= require 'models'

TripsLists = {}

class TripsReceptionListIemMyTrips extends WidgetListItem

  events:
    'click button' : 'openModel'

  openModel: =>
    console.log @model

  renderParams: ->
    'passenger': "<div>#{@model.get("passenger")}</div><div>#{@model.get("phone")}</div>"
    'trip': "<div>#{@model.get("from")}</div><div>#{@model.get("to")}</div>"
    'timer': "<div>#{@model.get("timer")}</div>"
    'button': "<button>Button</button>"

class TripsReceptionListMyTrips extends WidgetList
  listItemView: TripsReceptionListIemMyTrips

  className: "widgetList tripsReceptionList"

  headHtml: ->
    "<span> Pasajero / Telefono </span> <span> Origen / Destino </span>"


TripsLists.getReceptionListMyTrips = ->
  new TripsReceptionListMyTrips collection: new Trips()

#Exports
window.TripsLists = TripsLists