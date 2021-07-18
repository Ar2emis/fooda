# frozen_string_literal: true

class EventErrorLog < ApplicationRecord
  validates :data, :event_errors, presence: true
end
