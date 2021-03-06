require 'bank'
require 'transaction_history'

describe Bank do
  subject(:bank) { described_class.new }

  describe 'initialised' do
    it 'with the balance of 0' do
      expect(subject.balance).to be(0)
    end
    it 'with an instance of transaction_history' do
      expect(subject).to respond_to(:transaction_history)
    end
  end
  describe '#deposit' do
    it 'allows balance to be updated when depositing money' do
      expect{ subject.deposit(100) }.to change{ subject.balance }.by(100)
    end
    it 'does not allow depositing values of 0 or less' do
      expect{ subject.deposit(0) }.to raise_error("You cannot deposit £0, as it's £0 or less")
    end
    it 'pushes the transaction instance into transaction_history' do
      subject.deposit(100)
      expect(subject.transaction_history.transactions[0]).to eq({:date=>"07/03/2017", :credit=>100, :debit=>nil, :balance=>100})
    end
  end
  describe '#withdraw' do
    it 'decreases balance by withdrawn amount' do
      subject.deposit(100)
      expect{ subject.withdraw(100) }.to change{ subject.balance }.by(-100)
    end
    it 'does not allow withdrawing values if balance equals less than 0' do
      balance = 0
      expect{ subject.withdraw(10) }.to raise_error("You cannot withdraw £10, as your balance will be less than £0")
    end
    it 'pushes the transaction instance into transaction_history' do
      subject.deposit(100)
      subject.withdraw(100)
      expect(subject.transaction_history.transactions[1]).to eq({:date=>"07/03/2017", :credit=>nil, :debit=>100, :balance=>0})
    end
  end
end
