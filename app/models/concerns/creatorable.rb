# frozen_string_literal: true

module Creatorable
  extend ActiveSupport::Concern

  included do
    belongs_to :creator, class_name: 'User'
  end
end
