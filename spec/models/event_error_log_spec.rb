# frozen_string_literal: true

RSpec.describe EventErrorLog, type: :model do
  describe 'fields' do
    it { is_expected.to have_db_column(:data).with_options(null: false) }
    it { is_expected.to have_db_column(:event_errors).with_options(null: false) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:data) }
    it { is_expected.to validate_presence_of(:event_errors) }
  end
end
