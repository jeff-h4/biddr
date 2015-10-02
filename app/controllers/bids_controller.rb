class BidsController < ApplicationController
  def new
  end

  def create
    @bid = Bid.new bid_params
    @bid.user = current_user
    @bid.auction = Auction.find params[:auction_id]
    if @bid.save
      update_auction_current_price(@bid.auction,@bid.amount)
      redirect_to @bid.auction, notice: "Bid Successful"
    else 
      #render auction_path(@bid.auction), alert: "Bid Failed!"
      redirect_to "/auctions/" + @bid.auction.id.to_s, alert: "Bid Failed!"
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
