# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ActionView::RecordIdentifier

  add_flash_types :success, :warning, :danger, :info
end
