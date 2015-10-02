class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction

  validate :price_ok

  def price_ok
    if amount < auction.current_price
      # this will add to the errors object attached to the current object.
      # if the errors object is not an empty Hash then rails treats the
      # record as invalid
      errors.add(:amount, "must be greater than Auction's current price")
    end
  end


end
