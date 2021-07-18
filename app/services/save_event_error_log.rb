# frozen_string_literal: true

class SaveEventErrorLog < ApplicationService
  attr_reader :error_log

  def initialize(data, errors)
    super
    @data = data
    @errors = errors
  end

  def call
    @error_log = EventErrorLog.create(data: @data, event_errors: @errors)
  end
end
