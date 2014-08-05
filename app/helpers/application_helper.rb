module ApplicationHelper

  def prettify_provider (provider)
    if provider == 'google_oauth2'
      "Google"
    else
      provider
    end
  end
end
