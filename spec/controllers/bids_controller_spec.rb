require 'rails_helper'

RSpec.describe BidsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      def valid_request
        post :create, bid: attributes_for(:bid)
      end
      it "is added to the Bids database" do
        valid_request
        expect(Bid.count).to eq(1)
      end
      it "is associated with the current user" do
        user    = create(:user)
        login(user)
        post :create, bid: attributes_for(:bid).merge({user: user})
        expect(Bid.last.user.id).to eq(user.id)
      end
      it "is associated with an auction" do
        auction_owner   = create(:user)
        user            = create(:user)
        login(user)
        auction = create(:auction, user: auction_owner)
        post :create, auction_id: auction.id, bid: attributes_for(:bid).merge({auction: auction})
        expect(Bid.last.auction.id).to eq(auction.id)
      end
      it "redirects to the Auction Show page" do
        user    = create(:user)
        auction = create(:auction, user: user)
        bid     = create(:bid, auction: auction)
        post :create,  bid: bid
        expect(response).to redirect_to auctions_path (Bid.last.auction)
      end
      it "sets a flash notice message" do
        valid_request
        expect(flash[:notice]).to be
      end
    end
    context "with invalid parameters" do
      def invalid_request
        user    = create(:user)
        auction = create(:auction, user: user)
        bid     = create(:bid, auction: auction, amount: -1)
        post :create,  bid: bid
      end
      it "does not modify the Bids database" do
      end
      it "sets a flash alert message" do
        invalid_request
        expect(flash[:alert]).to be
      end
      it "renders the Auction Show page" do
        invalid_request
        expect(response).to render_template(auction.id)
      end
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    it "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end

end
