require 'oystercard'

describe Oystercard do

 context "balance on oystercard"

  describe '#balance' do
    it "checks the balance" do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do

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


  context "journey"
  describe '#in_journey?' do
    it { should respond_to(:in_journey?) }
  end

   describe '#touch_in' do
     it 'is initially not in journey' do
       expect(subject).not_to be_in_journey
     end
     it { should respond_to(:touch_in) }

     it 'is in journey' do
       subject.touch_in
       expect(subject).to be_in_journey
     end
   end

   describe '#touch_out' do
     it 'ends the journey' do
       subject.touch_in
       subject.touch_out
       expect(subject).not_to be_in_journey
    end
  end
end
