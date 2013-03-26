# NAVIGATOR
# Object to controll page navigation.
# Is here to solve crss dependecy problems.

#TODO This module was originally created to work over jQuery Mobile.
getNavigationControler = (pages,noLoggedPages,User, addPageTocContainer) ->
  views = {}
  currentPage = {}
  lastPage = ''
  renderHashPage= ->
    hash  = location.hash.replace('#','').toLowerCase()
    if User.isLoggedIn()
      if pages[hash]
        goToPage hash
      else if hash == 'logout'
        User.logOut()
      else if lastPage
        location.hash = lastPage
      else
        goToPage defaultPage
    else
      if noLoggedPages[hash]
        goToPage hash
      else if pages[hash]
        showLogin hash
      else if lastPage
        location.hash = lastPage
      else
        showLogin defaultPage

  goToPage = (pageName, changeHash = true, options) ->
    console.log "Going to page #{pageName}, #{(if changeHash then '' else 'not ')}changing hash"
    return if pageName == lastPage
    if pages[pageName] or noLoggedPages[pageName]
      console.log 'here'
      #$page = $("##{pageName}")
      #$page = views[pageName]
      view = views[pageName]
      unless view #s[pageName] #$page[0]
        console.log 'does not exist'
        view = (pages[pageName] or noLoggedPages[pageName])(id: pageName)
        return location.hash = lastPage unless view
        return if view.avoidActions
        views[pageName] = view
      view.render()
#      $page = view.$el
#      unless $page.hasClass 'ui-page-active' #TODO This condition is is currently not working.
      lastPage = pageName
      #navigate $page, options
      changePage view

    location.hash = lastPage if changeHash

  navigate = ($page, options = {}) =>
      console.log 'navigate'
      params = _.extend changeHash: false, options
      #$("body").append $page
      changePage $page, params

  #TODO Validate this options
  showLogin = (nextPage, options = {}) ->
      defaultOptions =
        reverse: true
      options = _.defaults options,defaultOptions
      nextPage = defaultPage unless pages[nextPage]
      view = noLoggedPages['login'] {nextPage}
      view.render()
      #$("body").append view.$el
      views['login'] = view
      goToPage 'login',true, options


  renderFirstPage = ->
    console.log 'called render first page'
    renderHashPage()
    $(window).bind "hashchange", -> renderHashPage()

  changePage = (view)->
    #location.hash = lastPage
    currentPage.remove() if currentPage.remove
    addPageTocContainer view.$el
    currentPage = view

  #TODO Add posibility to handle options by url params
  navigateToHash = (hash,options) ->
    location.hash =  hash
  User.onLogOut = showLogin
  return {renderHashPage,goToPage,navigate,showLogin,renderFirstPage,navigateToHash}


# Exports
window.getNavigationControler = getNavigationControler