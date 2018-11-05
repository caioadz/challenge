class Shipping
  attr_reader :items, :invoice

  def initialize
    raise 'This class should be inherited from, not instantiated.'
  end

  def ship
    #do shipment process
    p "#{label}"
  end

  def add_item(shipping_item)
    @items << shipping_item
  end

  def label
    raise 'You must implement this.'
  end
end