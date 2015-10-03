require 'rails_helper'

RSpec.describe BidsController, type: :controller do

  describe "POST #create" do
    context "with valid parameters" do
      before do
        auction_owner   = create(:user)
        @auction = create(:auction, user: auction_owner)
        @user    = create(:user)
        login(@user)
      end
      it "is added to the Bids database" do
        my_params = {auction_id: @auction.id, bid: attributes_for(:bid).merge({user: @user})}
        post :create, my_params
        expect(Bid.count).to eq(1)
      end
      it "is associated with the current user" do
        my_params = {auction_id: @auction.id, bid: attributes_for(:bid).merge({user: @user})}
        post :create, my_params
        expect(Bid.last.user.id).to eq(@user.id)
      end
      it "is associated with an auction" do
        my_params = {auction_id: @auction.id, bid: attributes_for(:bid).merge({auction: @auction})}
        post :create, my_params
        expect(Bid.last.auction.id).to eq(@auction.id)
      end
      it "redirects to the Auction Show page" do
        my_params = {auction_id: @auction.id, bid: attributes_for(:bid).merge({auction: @auction})}
        post :create,  my_params
        expect(response).to redirect_to("/auctions/" + Bid.last.auction_id.to_s)
      end
      it "sets a flash notice message" do
        my_params = {auction_id: @auction.id, bid: attributes_for(:bid).merge({auction: @auction})}
        post :create,  my_params
        expect(flash[:notice]).to be
      end
    end
    context "with invalid parameters" do
      def invalid_request
        user    = create(:user)
        login(user)
        @auction = create(:auction, user: user)
        my_params = {auction_id: @auction.id, bid: attributes_for(:bid).merge({user: user,
                                                                               amount: -1,
                                                                               auction: @auction})}
        post :create,  my_params
      end
      it "does not modify the Bids database" do
        invalid_request
        expect(Bid.count).to eq(0)
      end
      it "sets a flash alert message" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end
  end

end
