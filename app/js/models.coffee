#= require 'api'
#= require 'vendor_all'

class Trip extends Backbone.Model

class Trips extends Backbone.Collection
  url: Api.trips
  model: Trip
  parse: (response) ->
    console.log 'Parsed collection'
    response.trips

  fetch: => super
# Exports
window.Trips = Trips
