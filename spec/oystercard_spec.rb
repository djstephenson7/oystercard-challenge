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
  end
end
