#= require 'vendor_all'
#= require 'templates/trip_detail'

class TripDetail extends Backbone.View
  className: 'tripDetail'

  render: ->
    console.log @model.attributes
    @$el.html JST['templates/trip_detail'] trip: @model.attributes
    @$el

#Export
window.TripDetail = TripDetail
