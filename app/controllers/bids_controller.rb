class BidsController < ApplicationController
  def new
  end

  def create
    @bid = Bid.new bid_params
    @bid.user = current_user
    @bid.auction = params[:auction_id]
    @bid.save
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
