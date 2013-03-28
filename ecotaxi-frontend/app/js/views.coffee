#= require 'vendor_all'
#= require 'models'
#= require 'widgets'
#= require 'lists'

#View to show the list received trips from EcoTaxi to CityTax(or another operator)
#TODO Stop timeouts when the view is removed
class TripsReception extends DualPanelView

  remove: =>
    console.log 'removed reception'
    @listMyTrips.remove()
    @listAvailableTrips.remove()
    super

  render: =>
    super
    @listMyTrips = TripsLists.getReceptionListMyTrips @setOnSecondPanel
    @setOnFirstPanel @listMyTrips.$el, @listMyTrips
    @listMyTrips.render()
    @listAvailableTrips = TripsLists.getReceptionListAvailableTrips @setOnSecondPanel
    @addToFirstPanel @listAvailableTrips.$el, @listAvailableTrips
    @listAvailableTrips.render()
    window.listMyTrips =  @listMyTrips
    window.listAvailableTrips= @listAvailableTrips

#View to show and send trips to eco-taxi
class TripsDelivery extends DualPanelView
  remove: =>
    console.log 'removed delivery'
    super

  render: =>
    super
    @setOnFirstPanel '<h1>ESTA ES LA PAGINA DE ENVIO</h1>'
    @$el


#Exports
window.TripsReception = TripsReception
window.TripsDelivery = TripsDelivery


