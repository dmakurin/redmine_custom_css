# frozen_string_literal: true

class CustomCssController < ApplicationController
  before_action :find_user

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
end
