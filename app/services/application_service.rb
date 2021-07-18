# frozen_string_literal: true

class ApplicationService
  attr_reader :errors

  def self.call(*args)
    service = new(*args)
    service.call
    service
  end

  def call; end

  def initialize(*_args)
    @success = true
  end

  def success?
    @success
  end

  private

  def failure
    @success = false
  end
end
