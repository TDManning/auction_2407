class Auction
  attr_reader :items, :bidders

  def initialize
    @items = []
    @bidders = []
  end

  def add_item(item)
    @items << item
  end

  def item_names
    @items.map { |item| item.name }
  end

  def unpopular_items
    @items.select { |item| item.bids.empty? }
  end

  def potential_revenue
    @items.sum { |item| item.current_high_bid.to_i }
  end

  def bidder_info
    info = Hash.new { |hash, key| hash[key] = { budget: key.budget, items: [] } }
    @items.each do |item|
      item.bids.each_key do |attendee|
        info[attendee][:items] << item
      end
    end
    info
  end

    def bidders
    end
 
  end
end