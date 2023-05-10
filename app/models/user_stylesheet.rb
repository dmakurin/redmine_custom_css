# frozen_string_literal: true

class UserStylesheet < ActiveRecord::Base
  belongs_to :user
end
