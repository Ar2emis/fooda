# frozen_string_literal: true

require 'simplecov'

SimpleCov.start 'rails' do
  minimum_coverage 80

  add_group('Services', Dir['app/services/*.rb'])
  add_group('Workers', Dir['app/workers/*.rb'])
end
