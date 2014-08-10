@Tools = {}

class Tools.Site
  constructor: ->
    @packeryInitialized = false
    @packeryConfig =
      columnWidth:  '.column-width'
      itemSelector: 'article.post'
      gutter:       '.gutter-width'
      transitionDuration: '0.2s'

    @$body = $('body')
    @$container = $('.post-feed')
    @$packery = $('.post-feed')

    $(window).load => @buildView()

  buildView: (e, viewStyle) =>
    if @packeryInitialized
      imagesLoaded @$packery, =>
        @$packery.packery()
      @packeryInitialized = true
    else if !@mobile
      @$packery.packery(@packeryConfig)
      imagesLoaded @$packery, =>
        @$packery.packery()
      @packeryInitialized = true
