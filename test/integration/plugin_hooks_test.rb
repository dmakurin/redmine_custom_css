# frozen_string_literal: true

require File.expand_path("../../test_helper", __FILE__)

class PluginHooksTest < RedmineCustomCss::HelperTest
  fixtures :users, :user_stylesheets

  class TestHookHelperController < ActionController::Base
    include Redmine::Hook::Helper
  end

  class TestHookHelperView < ActionView::Base
    include Redmine::Hook::Helper
  end

  def setup
    @hook_module = Redmine::Hook
    @hook_module.clear_listeners
    @hook_module.add_listener(RedmineCustomCss::HookListener)
    @user = users(:users_002) # jsmith
  end

  def test_hook_view_layouts_base_html_head
    html = with_settings plugin_redmine_custom_css: { css: "div {color:white;}" }.with_indifferent_access do
      view_hook_helper.call_hook(:view_layouts_base_html_head)
    end

    # a plugin setting
    assert_match "div {color:white;}", html
    # plugin's styles
    assert_match "plugin_assets/redmine_custom_css/stylesheets/redmine_custom_css.css", html
  end

  def test_hook_view_layouts_base_body_bottom
    User.stubs(:current).returns(@user)
    html = view_hook_helper.call_hook(:view_layouts_base_body_bottom)

    # tag
    assert_match %r{<style type="text/css">.*</style>}, html
    # user's css
    assert_not_predicate @user.custom_css, :blank?
    assert_match @user.custom_css, html
  end

  def test_hook_view_my_account_contextual
    User.stubs(:current).returns(@user)
    html = view_hook_helper.call_hook(:view_my_account_contextual, { user: @user })

    # a contextual link on my/account
    assert_match edit_custom_css_path(@user), html
  end

  private

  def hook_helper
    @hook_helper ||= TestHookHelperController.new
  end

  def lookup_context
    @lookup_context ||= ActionView::LookupContext.new(ActionView::PathSet.new([Rails.root.join('app/views')]))
  end

  def view_hook_helper
    @view_hook_helper ||= TestHookHelperView.new(lookup_context, {}, hook_helper)
  end
end
