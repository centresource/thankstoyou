@Tools = {}

class Tools.Site
  constructor: ->
    @isotopeInitialized = false
    @isotopeConfig =
      layoutMode: 'masonry'
      # columnWidth:  '.column-width'
      # itemSelector: 'article.post'
      # gutter:       0
      # transitionDuration: '0.2s'

    @$body = $('body')
    @$container = $('.post-feed')
    @$isotope = $('.post-feed')

    @$body.on('click', '#load-more-posts', @loadMorePosts)

    $(window).load => @buildView()
    $(window).load => @scrollToFixed()

  buildView: (e, viewStyle) =>
    if @isotopeInitialized
      imagesLoaded @$isotope, =>
        @$isotope.isotope()
      @isotopeInitialized = true
    else
      @$isotope.isotope(@isotopeConfig)
      imagesLoaded @$isotope, =>
        @$isotope.isotope()
      @isotopeInitialized = true

  scrollToFixed: =>
    $('header.navigation').scrollToFixed();

  loadMorePosts: (e) =>
    e.preventDefault()
    $btn = $(e.target)
    $page = $btn.data('page')
    $page_total = $btn.data('total-pages')
    $isotope = @$isotope

    if $page > $page_total
      return

    $.ajax(
      url: "/get_posts?page="+$page
      context: document.body
      dataType: 'html'
    ).done (data) ->
      $btn.data('page', $page+1)
      $isotope.isotope('insert', $(data))
      imagesLoaded $isotope, =>
        $isotope.isotope('layout')

      if $btn.data('page') > $btn.data('total-pages')
        $btn.text('No more posts').addClass('disabled')



      return


