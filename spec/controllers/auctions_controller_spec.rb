require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do
  describe '#new' do
    context 'user not signed in' do
      it "redirects to sign-in page" do
      end
    end
    context 'user signed in' do
      it "renders the new Auction template" do
        get :new
        expect(response).to render_template(:new)
      end
      it "creates a new auction object" do
        get :new
        expect(assigns(:auction)).to be_a_new(Auction)
      end
    end
  end    
  describe '#create' do
    context 'user not signed in' do
      it "redirects to sign-in page" do
      end
    end
    context 'user signed in' do
      context 'with valid Auction parameters' do
        def valid_request
          post :create, auction: attributes_for(:auction)
        end
        it "adds Auction to the database" do
          valid_request
          expect(Auction.count).to eq(1)
        end
        it "redirects to the Auction Show page" do
          valid_request
          expect(response).to redirect_to auction_path(Auction.last.id)
        end
        it "associates the Auction with the signed-in user" do
        end
      end
      context 'with invalid Auction parameters' do
        def invalid_request
          post :create, auction: attributes_for(:auction).merge({title: nil})
        end
        it "renders the :new template" do
          invalid_request
          expect(response).to render_template(:new)
        end
        it "does not add Auction to the database" do
          invalid_request
          expect(Auction.count).to eq(0)
        end
      end
    end
  end
end
