class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_user!
    redirect_to new_session_path, notice: "please sign in" unless user_signed_in?
  end

  def current_user
    @current_user ||= User.find_by_id session[:user_id]
  end
  helper_method :current_user

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def sign_in(user)
    session[:user_id] = user.id
  end

  def update_auction_current_price(auction,current_bid)
    auction.current_price = current_bid + 1
    auction.save
  end
  helper_method :update_auction_current_price
  def check_reserve_price_met(auction)
    if auction.current_price >= auction.reserve_price
      auction.surpassed_reserve!
    end
  end
  helper_method :check_reserve_price_met

end
