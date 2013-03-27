#= require 'widgets'
#= require 'models'

TripsLists = {}
#########################################
########################################
# TRIPS RECEPTION
class TripsReceptionListItem extends WidgetListItem

  events:
    'click button' : 'openModel'
  buttonText: 'Button'

  openModel: =>
    console.log @model
  button: ->
    "<button>Button</button>"

  renderParams: =>
    'passenger': "<div>#{@model.get("passenger")}</div><div>#{@model.get("phone")}</div>"
    'trip': "<div>#{@model.get("from")}</div><div>#{@model.get("to")}</div>"
    'timer': "<div>#{@model.get("timer")}</div>"
    'button': @button()

class TripsReceptionList extends WidgetList
  listItemView: TripsReceptionListItem
  className: "widgetList tripsReceptionList"

  headHtml: ->
    head =
        'passenger': "Pasajero / Telefono"
        'trip': "Origen / Destino"
        'timer': ''
        'button': ''
    JST['templates/widget_list_item'] values: head

####################
# Available Trips
class TripsReceptionListItemAvailableTrips extends TripsReceptionListItem
  button: -> "<button>Reservar</button>"

class TripsReceptionListAvailbleTrips extends TripsReceptionList
  listItemView: TripsReceptionListItemAvailableTrips
  listTitle: 'PENDIENTES'

###################
# My trips
class TripsReceptionListItemMyTrips extends TripsReceptionListItem
  button: -> "<button>Cancelar</button>"


class TripsReceptionListMyTrips extends TripsReceptionList
  listItemView: TripsReceptionListItemMyTrips
  listTitle: 'MIS DESPACHOS'

##################
#TODO Specify the correct collections
TripsLists.getReceptionListMyTrips = ->
  new TripsReceptionListMyTrips collection: new Trips()

TripsLists.getReceptionListAvailableTrips = ->
  new TripsReceptionListMyTrips collection: new Trips()

#Exports
window.TripsLists = TripsLists