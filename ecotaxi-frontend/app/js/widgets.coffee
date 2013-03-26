#= require 'util'

class WidgetListItem extends Backbone.View
  tagName: 'tr'
  className: 'widgetListItem'
  shownAttrs: ['id','start','end','driver','car', 'lic_plate', 'passenger', 'status']
  events:
    "click .see" : "onClickSee"

  onClickSee: ->
    alert "Hisciste click en ver"

  update: (changed) =>
#    console.log changed
    #@$el.html JST['templates/trips_list_item'](@model.attributes)
    for key, value of changed
      @$(".#{key}").html value

  initialize: ->
    @model.on 'change', => @update @model.changedAttributes()
    @model.on 'remove',@remove

  remove: =>
    super
    @trigger 'remove'
#    console.log 'removed'

  render: =>
    @$el.html JST['templates/widget_list_item'] values: _.subHash @model.attributes, @shownAttrs
    @$el.attr 'id', @model.get 'id'
    @$el

class WidgetList extends Backbone.View

  className: "widgetList"
  $itemsContainer: undefined
  tagName: 'table'
  itemViews: {}
  headers: ['Pasajero/Telefono', 'Origen/Destino','','']
  updateTimeout: null

  update: =>
    @collection.fetch success: @loadList
    @updateTimeout = setTimeout(@update,2000)

  remove: =>
    super()
    clearTimeout @updateTimeout

  render: =>
    @$el.html JST['templates/widget_list'](headers: @headers)
    @$itemsContainer = @$(".itemsContainer")
    @update()
    @$el

  renderEmptyList: =>
    @$itemsContainer.html 'No Hay nada'

  loadList: =>
    count = @itemCount()
    #@$itemsContainer.html ''
    return @renderEmptyList() unless count
    for i in [0..count - 1]
      item = @itemViewAt i
      if item and !(@$(item.$el)[0])
        @$itemsContainer.append item.$el
#        item.delegateEvents()

  itemCount: ->
    @collection.length

  itemViewAt: (index) ->
    model =  @modelAt index
    unless @itemViews[model.id]
      view = new WidgetListItem model: model
      @itemViews[model.id] = view
      view.on 'remove', => delete @itemViews[model.id]
      view.render()
    @itemViews[model.id]


  modelAt: (index) ->
    @collection.at index


#Menu Widget
class Menu extends Backbone.View
  #TODO Allow use of custom functions when clicking on an item (Right now, it'll just change the url)
  events:
    'click .opener' : 'show'

  className: 'menu'
  autohide: true
  autohideTime: 20000
  autohideTimeout: null
  #Entries is a list of items.
  # Each item is an objet that can be a submenu or a menu item
  # Each item contains a string to be show, and if it is a menu item
  # It must contain the url to go (the url is set to an anchor)
  # if it is a submenu, it must contain a list of items.
  # EX:
  # entries = [ {type: 'item', text: 'This is an item', url: '#item'},
  #             {type: 'submenu', text: 'this is a submenu', items: [
  #                  {type: 'item', text: 'This is 1st subitem', url: '#subitem1'}
  #                  {type: 'item', text: 'This is 2nd subitem', url: '#subitem2'}
  #              }]
  #           ]
  render: =>
    @$el.html JST['templates/menu']()
    createMenu = (entries = [], $el) ->
      getItem = (item, isSubmenu = false) ->
        $(JST['templates/menu_item'] {item, isSubmenu} )
      for item in entries
        if item.type == 'submenu'
          arg = text: item.text || 'Some text'
          container = getItem arg, true
          console.log container.find('.itemsContainer')
          createMenu(item.items, container.find('.itemsContainer'))
          $el.append container
        else
          arg =
            url: item.url || 'javascript:void(0)'
            text: item.text || 'Some text'
          $el.append getItem arg

    createMenu(@entries, @$('.items'))
    @$el

  show: =>
    #@$('.opener').hide()
    #@$('.items').show 'slow'
    @$el.removeClass('closed')
    clearTimeout @
    @autohideTimeout = setTimeout @hide, @autohideTime


  hide: =>
    @$el.addClass('closed')
    #@$('.items').hide 'slow'
    #@$('.opener').show()


  initialize: =>
    @entries = @options.entries || []

# Exports
window.WidgetList = WidgetList
window.WidgetListItem = WidgetListItem
window.Menu = Menu