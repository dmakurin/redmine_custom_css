# frozen_string_literal: true

class CustomCssController < ApplicationController
  before_action :find_user, :authorize

  def edit
  end

  def update
    @stylesheet.custom_css = css_params[:custom_css]
    if @stylesheet.save
      flash[:notice] = l(:notice_successful_update)
      redirect_to edit_custom_css_path
    else
      flash[:error] = @stylesheet.errors.full_message.to_sentence
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
    @stylesheet = @user.stylesheet || @user.build_stylesheet
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def css_params
    params.require(:user_stylesheet).permit(:custom_css)
  end

  # /users/:id/custom_css/edit is accessible only for:
  # * admin
  # * current user
  def authorize
    return if User.current.admin?

    render_403 unless User.current.id == @user.id
  end
end
