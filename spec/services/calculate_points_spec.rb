# frozen_string_literal: true

RSpec.describe CalculatePoints, type: :service do
  describe '.call' do
    let(:service) { described_class.call(*params) }

    context 'when different order creation time' do
      [
        { hour: 9.99, amount: 12 },
        { hour: 10, amount: 3 },
        { hour: 10.5, amount: 3 },
        { hour: 11, amount: 6 },
        { hour: 11.5, amount: 6 },
        { hour: 12, amount: 9 },
        { hour: 12.5, amount: 9 },
        { hour: 13, amount: 6 },
        { hour: 13.5, amount: 6 },
        { hour: 14, amount: 3 },
        { hour: 14.5, amount: 3 },
        { hour: 14.99, amount: 3 },
        { hour: 15, amount: 12 }
      ].each do |data|
        it "calculates #{described_class::POINTS_RANGE.min} points" do
          date = DateTime.new(Time.zone.now.year, Time.zone.now.month, Time.zone.now.day, data[:hour])
          expect(described_class.call(data[:amount], date).points).to eq described_class::POINTS_RANGE.min
        end
      end
    end

    context "when reward is lower than #{described_class::POINTS_RANGE.min}" do
      let(:params) { [0, Time.zone.now] }

      it { expect(service.points).to be_zero }
    end

    context "when order reward is more than #{described_class::POINTS_RANGE.max}" do
      let(:params) { [described_class::POINTS_RANGE.max * 5, Time.zone.now] }

      it { expect(service.points).to be_zero }
    end
  end
end
