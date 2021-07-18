# frozen_string_literal: true

RSpec.describe ApplicationService, type: :service do
  describe '.call' do
    let(:result) { described_class.call }

    it { expect(result).to be_a described_class }
    it { expect(result).to be_success }
  end
end
