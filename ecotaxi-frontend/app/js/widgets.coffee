#= require 'util'

class TripsListItem extends Backbone.View
  tagName: 'li'
  className: 'tripListItem'
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

  className: "widget-box trip-list"
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



# Exports
window.TripsList = TripsList