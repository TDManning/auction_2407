require './lib/item'
require './lib/auction'
require './lib/attendee'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe Auction do
  before(:each) do
    @auction = Auction.new
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
    @item3 = Item.new('Homemade Chocolate Chip Cookies')
    @item4 = Item.new('2 Days Dogsitting')
    @item5 = Item.new('Forever Stamps')
    @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
    @attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
    @attendee3 = Attendee.new({name: 'Mike', budget: '$100'})
  end

  describe '#initialize' do
    it 'starts with attributes' do
      expect(@auction).to be_an_instance_of(Auction)
      expect(@auction.items).to eq([])
    end
  end

    it 'adds auction items' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      expect(@auction.items).to eq([@item1, @item2])
      expect(@auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
    end

    it 'itentifies unpopular items' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)

      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      @item4.add_bid(@attendee3, 50)

      expect(@auction.unpopular_items).to eq [@item2, @item3, @item5]
    end

    it 'updates unpopular_items array' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)

      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      @item4.add_bid(@attendee3, 50)
      @item3.add_bid(@attendee2, 15)

      expect(@auction.unpopular_items).to eq [@item2, @item5]
    end

    it 'adds potential revenue' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)

      @item1.add_bid(@attendee1, 22)
      @item4.add_bid(@attendee3, 50)
      @item3.add_bid(@attendee2, 15)

      expect(@auction.potential_revenue).to eq(87)
    end

    it 'gives bidder info' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)
  
      @item1.add_bid(@attendee1, 20)
      @item1.add_bid(@attendee2, 30)
      @item2.add_bid(@attendee2, 40)
      @item3.add_bid(@attendee3, 50)

    expected_bidder_info =  {
        @attendee1 => {
          budget: 50,
          items: [@item1]
        },
        @attendee2 => {
          budget: 75,
          items: [@item1, @item2]
        },
        @attendee3 => {
          budget: 100,
          items: [@item3]
        }
      }
    expect(@auction.bidder_info).to eq(expected_bidder_info)
    end

    it 'gives an array of bidders names' do
      expect(@auction.bidders).to eq(["Megan", "Bob", "Mike"])
    end
end