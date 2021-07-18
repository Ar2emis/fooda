# frozen_string_literal: true

RSpec.describe Customer, type: :model do
  describe 'fields' do
    it { is_expected.to have_db_column(:name).with_options(null: false) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:orders) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
