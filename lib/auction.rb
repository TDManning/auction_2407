class Auction
  attr_reader :items

  def initialize
    @items = []
  
  end

  def add_item(item)
    @items << item
  end

  def item_names
    @items.map { |item| item.name }
  end



  def unpopular_items

  end

  def potential_revenue

  end
end