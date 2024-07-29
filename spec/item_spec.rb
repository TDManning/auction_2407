require './lib/item'
require './lib/auction'
require './lib/attendee'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe Item do
  before(:each) do
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
  end

  describe '#initialize' do
    it 'starts with attributes' do
      expect(@item1).to be_an_instance_of(Item)
      expect(@item2).to be_an_instance_of(Item)
      expect(@item1.name).to eq("Chalkware Piggy Bank")
    end
  end
end