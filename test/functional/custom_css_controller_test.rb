# frozen_string_literal: true

require File.expand_path("../../test_helper", __FILE__)

class CustomCssControllerTest < RedmineCustomCss::ControllerTest
  fixtures :users, :user_stylesheets

  def setup
    @request.session[:user_id] = 2 # jsmith
    @user = users(:users_002)
  end

  def test_edit
    get :edit, params: { id: @user.id }

    assert_response :success
    assert_select "form#edit_user_stylesheet_1"
    assert_select "textarea#user_stylesheet_custom_css", text: "h1 {color: black;}"
  end

  def test_update
    patch :update, params: {
      id: @user.id,
      user_stylesheet: { custom_css: "h2 {background-color: red;}" },
    }

    assert_redirected_to controller: "custom_css", action: "edit", id: @user.id
    assert_equal "h2 {background-color: red;}", @user.custom_css
  end

  def test_access_denied_when_accessing_another_user_custom_css
    @request.session[:user_id] = 3 # dlopper
    get :edit, params: { id: @user.id }

    assert_response :forbidden
  end

  def test_admin_can_access_users_custom_css
    @request.session[:user_id] = 1 # admin
    get :edit, params: { id: @user.id }

    assert_response :success
    assert_select "form#edit_user_stylesheet_1"
  end
end
