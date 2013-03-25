#= require 'util'

class TripsListItem extends Backbone.View
  tagName: 'tr'
  className: 'listItem tripListItem'
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
    attrs = ['id','start','end','driver','car', 'lic_plate', 'passenger', 'status']
    @$el.html JST['templates/trips_list_item'] values: _.subHash @model.attributes, attrs
    @$el.attr 'id', @model.get 'id'
    @$el

class TripsList extends Backbone.View

  className: "listWidget trip-list"
  $itemsContainer: undefined
  itemViews: {}

  update: =>
    @collection.fetch success: @loadList
    setTimeout(@update,2000)

  render: =>
    @$el.html JST['templates/trips_list']()
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
      view = new TripsListItem model: model
      @itemViews[model.id] = view
      view.on 'remove', => delete @itemViews[model.id]
      view.render()
    @itemViews[model.id]


  modelAt: (index) ->
    @collection.at index

class Menu extends Backbone.View
  #TODO Allow use of custom functions when clicking on an item (Right now, it'll just change the url)
  className: 'menu'
  #Entries is a list of items.
  # Each item is an objet that can be a submenu or a menu item
  # Each item contains a string to be show, an if is a menu item
  # It must contain the url to go (via an a)
  # if it is a submenu, it must contain a list of items.
  # EX:
  # entries = [ {type: 'item', text: 'This is an item', url: '#item'},
  #             {type: 'submenu', text: 'this is a suvmenu', items: [
  #                  {type: 'item', text: 'This is 1st subitem', url: '#subitem1'}
  #                  {type: 'item', text: 'This is 2nd subitem', url: '#subitem2'}
  #              }]
  #           ]
  render: =>
    @$el.html ''
    createMenu = (entries = [], $el) ->
      getItem = (item, isSubmenu = false) ->
        console.log {item, isSubmenu}
        $(JST['templates/menu_item'] {item, isSubmenu} )
      for item in entries
        console.log item.type
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

    createMenu(@entries, @$el)
    @$el

  initialize: =>
    @entries = @options.entries || []

# Exports
window.TripsList = TripsList
window.Menu = Menu