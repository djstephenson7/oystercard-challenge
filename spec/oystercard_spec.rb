require 'oystercard'

describe Oystercard do

   describe '#initialize' do
     it 'contains an empty array of journeys' do
       expect(subject.journey_history).to eq []
     end
   end
  context 'balance on oystercard'
  describe '#balance' do
    it 'checks the balance' do
      expect(subject.balance).to eq 0
    end
  end


  context 'Adding money and setting the balance limit'
  describe '#top_up' do
    it 'adds money' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it 'sets the limit at £90' do
      maximum_balance = Oystercard::LIMIT
      subject.top_up(maximum_balance)
      expect { subject.top_up(1) }.to raise_error "You have exceeded your £#{maximum_balance} limit!"
    end
  end

  context 'Paying the fare and deducting from the balance'

  describe '#pay_fare' do
    it { should respond_to(:pay_fare).with(1).argument }
  end

  it 'deducts money from the balance' do
    expect(subject.pay_fare(5)).to eq -5
  end


  context 'journey sequence'

  describe '#in_journey?' do
    it { should respond_to(:in_journey?) }
  end

  describe '#touch_in' do
    let(:station) { double :station }

    it 'is initially not in journey' do
      expect(subject).not_to be_in_journey
    end

    it 'prevents journey if insufficient balance' do
      expect { subject.touch_in(station) }.to raise_error("Insufficient balance!")
    end

    it "stores the entry station" do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject.journey_hash).to eq({entry_station: station})
    end

    it 'is in journey' do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end
  end

  describe '#touch_out' do
    let(:station) { double :station }
    let(:exit_station) { double :station }
    let(:entry_station) { double :station }
    it 'ends the journey' do
      subject.top_up(5)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-Oystercard::MINIMUM)
    end

    it 'ends the journey' do
      subject.top_up(5)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
      expect(subject.journey_history).to eq [{entry_station: entry_station, exit_station: exit_station}]
    end

    it 'clears journey hash' do
      subject.top_up(5)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
      expect(subject.journey_hash).to eq nil
    end
  end
end
