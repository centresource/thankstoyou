class @GoogleAnalytics

  @load: ->

    ((i, s, o, g, r, a, m) ->
        i["GoogleAnalyticsObject"] = r
        i[r] = i[r] or ->
          (i[r].q = i[r].q or []).push arguments

        i[r].l = 1 * new Date()

        a = s.createElement(o)
        m = s.getElementsByTagName(o)[0]

        a.async = 1
        a.src = g
        m.parentNode.insertBefore a, m
      ) window, document, "script", "//www.google-analytics.com/analytics.js", "ga"

    ga('create', GoogleAnalytics.analyticsId(), 'thankstoyousteve.com');

    GoogleAnalytics.addOutbound()

    # If Turbolinks is supported, set up a callback to track pageviews on page:change.
    # If it isn't supported, just track the pageview now.
    if typeof Turbolinks isnt 'undefined' and Turbolinks.supported
      document.addEventListener "page:change", (->
        GoogleAnalytics.trackPageview()
      ), true
    else
      GoogleAnalytics.trackPageview()

  @trackPageview: (url) ->
    unless GoogleAnalytics.isLocalRequest()
      if url
        window._gaq.push ["_trackPageview", url]
      else
        ga 'send', 'pageview';

  @trackOutbound: (url) ->
    ga 'send', 'event', 'outbound', 'click', url, 'hitCallback': ->
      # document.location = url
      return
    return

  @isLocalRequest: ->
    GoogleAnalytics.documentDomainIncludes "local"

  @documentDomainIncludes: (str) ->
    document.domain.indexOf(str) isnt -1

  @analyticsId: ->
    # your google analytics ID(s) here...
    'UA-53824033-1'

  @addOutbound: ->
    $('a[target="_blank"]').each ->
      $href = $(this).attr('href')
      $(this).attr('onclick', 'GoogleAnalytics.trackOutbound(\'' + $href + '\');')

GoogleAnalytics.load()
