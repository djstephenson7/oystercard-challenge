require 'oystercard'

describe Oystercard do

  describe 'balance' do
    it "checks the balance" do
      expect(subject.balance).to eq 0
    end
  end

  describe 'top_up' do

    it 'adds money' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it "sets the limit at £90" do
      maximum_balance = Oystercard::LIMIT
      subject.top_up(maximum_balance)
      expect{subject.top_up(1)}.to raise_error "You have exceeded your £#{maximum_balance} limit!"
    end
  end

  describe '#pay_fare' do
      it { should respond_to(:pay_fare).with(1).argument }
  end
    it "deducts money from the balance" do
      expect(subject.pay_fare(5)).to eq -5
  end
end
