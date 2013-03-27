#= require 'util'

class WidgetListItem extends Backbone.View
  tagName: 'li'
  className: 'widgetListItem'

  update: (changed) =>
    for key, value of changed
      @$(".#{key}").html value

  initialize: ->
    @model.on 'change', => @update @model.changedAttributes()
    @model.on 'remove',@remove

  remove: =>
    super
    @trigger 'remove'

  renderParams: ->
    @model.attributes

  render: =>
    @$el.html JST['templates/widget_list_item'] values: @renderParams()
    @$el.attr 'id', @model.get 'id'
    @$el

class WidgetList extends Backbone.View

  className: "widgetList"
  itemViews: {}
  $itemsContainer: undefined
  updateTimeout: undefined
  listItemView: WidgetListItem

  headHtml: ->
    'this is the list head'

  update: =>
    @collection.fetch success: @loadList
    @updateTimeout = setTimeout(@update,2000)

  remove: =>
    super()
    clearTimeout @updateTimeout

  render: =>
    @$el.html JST['templates/widget_list'](head: @headHtml())
    @$itemsContainer = @$(".itemsContainer")
    @update()
    @$el

  renderEmptyList: =>
    @$itemsContainer.html 'There is no items to show'

  loadList: =>
    count = @itemCount()
    @$itemsContainer.html ''
    return @renderEmptyList() unless count
    for i in [0..count - 1]
      item = @itemViewAt i
      @$itemsContainer.append item.$el
      item.delegateEvents()

  itemCount: ->
    @collection.length

  itemViewAt: (index) ->
    model =  @modelAt index
    unless @itemViews[model.id]
      view = new @listItemView model: model
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
  autohideTimeout: undefined
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


class DualPanelView extends Backbone.View
  className: 'dualPanelView'

  firstPanelView: undefined
  secondPanelView: undefined

  setOnFirstPanel: ($el, view) =>
    @firstPanelView.remove() if @firstPanelView
    @$(".panel1").html $el
    @firstPanelView = view

  setOnSecondPanel:($el, view) =>
    @secondPanelView.remove() if @secondPanelView
    @$(".panel2").html $el
    @secondPanelView = view

  render: =>
    @$el.html JST['templates/dual_panel_view']()
    @$el

# Exports
window.WidgetList = WidgetList
window.WidgetListItem = WidgetListItem
window.DualPanelView = DualPanelView
window.Menu = Menu