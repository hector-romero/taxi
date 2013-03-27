#= require 'vendor_all'
#= require 'models'
#= require 'widgets'
#= require 'lists'

#View to show the list received trips from EcoTaxi to CityTax(or another operator)
#TODO Stop timeouts when the view is removed
class TripsReception extends DualPanelView

  remove: =>
    console.log 'removed reception'
    @list.remove()
    super

  render: =>
    super
    @list = TripsLists.getReceptionListMyTrips()
    @setOnFirstPanel @list.$el, @list
    @list.render()

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


