#= require 'vendor_all'
#= require 'models'
#= require 'widgets'
#= require 'views'
#= require 'navigator'
#= require_directory './templates/'

class Applicaction extends Backbone.View

  menuEntries: [
    {type: 'item',     text: 'Dashboard',  url: '#'}
    {type: 'submenu',  text: 'Config',     items:[
        {type: 'item', text: 'Usuarios',   url: '#'}
        {type: 'item', text: 'Mercados',   url: '#'}
      ]
    }
    {type: 'submenu',  text: 'Despacho',   items:[
        {type: 'item', text: 'Recepcion',  url: '#despacho_recepcion'}
        {type: 'item', text: 'Envío',      url: '#despacho_envio'}
      ]
    }
    {type: 'submenu',  text: 'Choferes',   items:[
        {type: 'item', text: 'Agregar',    url: '#'}
        {type: 'item', text: 'Listado',    url: '#'}
      ]
    }
    {type: 'submenu',  text: 'Usuarios',   items:[
        {type: 'item', text: 'Agregar',    url: '#'}
        {type: 'item', text: 'Listado',    url: '#'}
      ]
    }
    {type: 'submenu',  text: 'Empresas',   items:[
        {type: 'item', text: 'Agregar',    url: '#'}
        {type: 'item', text: 'Listado',    url: '#'}
      ]
    }
    {type: 'item',     text: 'Mensajeria', url: '#'}
    {type: 'item',     text: 'Reportes',   url: '#'}
  ]

  initialize: ->
    @render()

  setOnContainer: ($el) =>
    console.log 'heeere'
    @$(".container").html ''
    @$(".container").append $el

  render: =>
    @$el.html JST['templates/application']()
    @menu = new Menu entries: @menuEntries, el: @$(".menu")
    @menu.render()
    @menu.show()
    window.menu = @menu
    @$el

appOnLoad = ->
  App = new Applicaction el: $("body")[0]
  pages =
    'default': ->
      App.navigator.navigateToHash 'despacho_recepcion'
      {avoidActions: true}
    'despacho_recepcion': ->
      view = new TripsReception()
      #@$(".container").append view.$el
#      view.render()
    'despacho_envio': ->
      view = new TripsDelivery()
      #@$(".container").append view.$el
#      view.render()
      view


  window.defaultPage = 'default'
  App.navigator  = getNavigationControler(pages, {},{isLoggedIn: -> true}, App.setOnContainer)
  App.navigator.renderFirstPage()

  window.App = App
window.appOnLoad = appOnLoad