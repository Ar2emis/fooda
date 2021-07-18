# frozen_string_literal: true

RSpec.describe Order, type: :model do
  describe 'fields' do
    it { is_expected.to have_db_column(:amount).with_options(null: false) }
    it { is_expected.to have_db_column(:customer_id).with_options(null: false) }
    it { is_expected.to have_db_column(:points).with_options(default: 0) }
    it { is_expected.to have_db_column(:utc_offset) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:customer) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:utc_offset) }
    it { is_expected.to validate_numericality_of(:amount) }
    it { is_expected.to validate_numericality_of(:utc_offset) }
  end
end
