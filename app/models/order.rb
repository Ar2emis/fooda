# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :customer

  validates :amount, :utc_offset, presence: true
  validates :amount, :utc_offset, :points, numericality: true
end
