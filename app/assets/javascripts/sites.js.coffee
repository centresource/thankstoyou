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

    if $('section.watch').length
      @$sectionWidth = $('section.watch').width()

      $(window).load => @formatIssuu()
      $(document).ready => @formatVideo()
      $(window).resize =>
        @$sectionWidth = $('section.watch').width()
        @formatVideo()
        @formatIssuu()

    if window.location.hash == '#thanks'
      $('#modal-2').prop('checked', true)

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

  formatVideo: (e) =>
    $vidHeight = @$sectionWidth * 9/16
    $('iframe#video-wrapper').attr('width', @$sectionWidth).attr('height', $vidHeight)

  formatIssuu: (e) =>
    $issuuHeight = @$sectionWidth / 1.54
    $('.issuuembed div[style^="height:18"]').hide()
    $('.issuuembed').attr('style', 'width:'+@$sectionWidth+'px; height:'+$issuuHeight+'px;')
