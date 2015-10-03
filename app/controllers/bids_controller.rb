class BidsController < ApplicationController
  def new
  end

  def create
    @auction = Auction.find params[:auction_id]
    @bid = Bid.new bid_params
    @bid.user = current_user
    @bid.auction = @auction
    if @bid.save
      update_auction_current_price(@bid.auction,@bid.amount)
      redirect_to @bid.auction, notice: "Bid Successful"
    else 
     flash[:alert] = "Bid Failed!"
     render "/auctions/show"
    end
  end

  def edit
  end

  def update
  end
  private
  def bid_params
    params.require(:bid).permit(:amount)
  end
end
