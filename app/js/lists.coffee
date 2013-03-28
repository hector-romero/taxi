#= require 'widgets'
#= require 'models'
#= require 'trip_detail'

TripsLists = {}
#########################################
########################################
# TRIPS RECEPTION
class TripsReceptionListItem extends WidgetListItem

  events:
    'click button' : 'openModel'
  buttonText: 'Button'

  openModel: =>
    detail = new TripDetail model: @model
    detail.render()
    @options.showView detail.$el,detail

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

  itemViewAt: (index) ->
    model =  @modelAt index
    unless @itemViews[model.id]
      view = new @listItemView model: model, showView: @options.showView
      @itemViews[model.id] = view
      view.on 'remove', => delete @itemViews[model.id]
      view.render()
    @itemViews[model.id]

####################
# Available Trips
class TripsReceptionListItemAvailableTrips extends TripsReceptionListItem
  button: -> "<button class='choose'>Reservar</button>"

class TripsReceptionListAvailableTrips extends TripsReceptionList
  listItemView: TripsReceptionListItemAvailableTrips
  listTitle: 'PENDIENTES'
  className: "widgetList tripsReceptionList availableTripsList"

###################
# My trips
class TripsReceptionListItemMyTrips extends TripsReceptionListItem
  button: -> "<button class='cancel'>Cancelar</button>"


class TripsReceptionListMyTrips extends TripsReceptionList
  listItemView: TripsReceptionListItemMyTrips
  listTitle: 'MIS DESPACHOS'
  className: "widgetList tripsReceptionList myTripsList"

##################
#TODO Specify the correct collections
TripsLists.getReceptionListMyTrips = (showView = ->null)->
  new TripsReceptionListMyTrips collection: new Trips(), showView: showView

TripsLists.getReceptionListAvailableTrips = (showView =  ->null) ->
  new TripsReceptionListAvailableTrips collection: new Trips(), showView: showView

#Exports
window.TripsLists = TripsLists