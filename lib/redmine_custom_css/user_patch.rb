# frozen_string_literal: true

module RedmineCustomCss
  module UserPatch
    extend ActiveSupport::Concern

    included do
      include InstanceMethods
      has_one :stylesheet, class_name: "UserStylesheet", dependent: :destroy
    end

    module InstanceMethods
      # Returns user's styles and stores it in the Rails.cache
      # Cache will be expired in 33 days, just in case
      def custom_css
        return "" unless stylesheet

        Rails.cache.fetch(stylesheet, expires_in: 33.days) do
          stylesheet.custom_css
        end
      end
    end
  end
end

base = User
patch = RedmineCustomCss::UserPatch
base.include patch unless base.included_modules.include? patch
