require 'oystercard'

describe Oystercard do
  let(:station) { double :station }
  let(:exit_station) { double :station }
  let(:entry_station) { double :station }

  describe '#initialize' do
    it 'contains an empty array of journeys' do
      expect(subject.journey_history).to eq []
    end
  end

  describe '#balance' do
    it 'checks the balance' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up - adds money, sets balance limit' do
    context 'when total amount less than balance limit' do
      it 'adds money' do
        expect(subject).to respond_to(:top_up).with(1).argument
      end
    end

    context 'when total amount over balance limit' do
      it 'raises balance limit error' do
        maximum_balance = Oystercard::LIMIT
        subject.top_up(maximum_balance)
        expect { subject.top_up(1) }.to raise_error "You have exceeded your £#{maximum_balance} limit!"
      end
    end
  end

  describe '#pay_fare - deducts money from balance' do
    it 'deducts money from the balance' do
      expect(subject.pay_fare(5)).to eq -5
    end
  end

  # context 'journey sequence'
  describe '#touch_in' do
    it 'is initially not in journey' do
      expect(subject).not_to be_in_journey
    end

    it 'prevents journey if insufficient balance' do
      expect { subject.touch_in(station) }.to raise_error("Insufficient balance!")
    end
    context 'touches in succesfully' do
      before do
        subject.top_up(5)
        subject.touch_in(station)
      end
      it "stores the entry station" do
        expect(subject.journey_hash).to eq({entry_station: station})
      end

      it 'is in journey' do
        expect(subject).to be_in_journey
      end
    end
  end

  describe '#touch_out - ends journey, stores station and clears journey hash' do
    before do
      subject.top_up(5)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
    end

    it 'deducts the fare from the balance' do
      expect(subject.balance).to eq(3)
    end

    it 'sets in_journey to false' do
      expect(subject).not_to be_in_journey
    end

    it 'adds station to :exit_station' do
      expect(subject.journey_history).to eq [{entry_station: entry_station, exit_station: exit_station}]
    end

    it 'clears journey hash' do
      expect(subject.journey_hash).to eq nil
    end
  end
end
