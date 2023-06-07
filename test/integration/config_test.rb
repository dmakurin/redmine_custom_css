# frozen_string_literal: true

require File.expand_path("../../test_helper", __FILE__)

class ConfigTest < RedmineCustomCss::IntegrationTest
  def test_allowed_css
    assert_includes RedmineCustomCss::Config::CSS[:css][:protocols], "data"
  end
end
