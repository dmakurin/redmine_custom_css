# frozen_string_literal: true

module RedmineCustomCss
  # Allows to use a "data" protocol in a url function:
  #   background-image: url("data:svg+xml,your-svg-icon");
  class Config
    CSS = Sanitize::Config.merge(
      Sanitize::Config::RELAXED,
      css: { protocols: Sanitize::Config::RELAXED[:css][:protocols] + ["data"] }
    )
  end
end
