#= require 'vendor_all'
#= require 'models'
#= require 'widgets'

#View to show the list received trips from EcoTaxi to CityTax(or another operator)
#TODO Stop timeouts when the view is removed
class TripsReception extends Backbone.View

  remove: =>
    console.log 'removed reception'
    @list.remove()
    super

  render: =>
    @list = new WidgetList collection: new Trips()
    @$el.append @list.$el
    @list.render()

#View to show and send trips to eco-taxi
class TripsDelivery extends Backbone.View
  remove: =>
    console.log 'removed delivery'
    super

  render: =>
    @$el.html '<h1>ESTA ES LA PAGINA DE ENVIO</h1>'


#Exports
window.TripsReception = TripsReception
window.TripsDelivery = TripsDelivery


