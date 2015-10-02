class User < ActiveRecord::Base
  has_secure_password
  has_many :auctions, dependent: :destroy
  has_many :bids, dependent: :nullify
  def full_name
    "#{first_name} #{last_name}".squeeze(" ").strip
  end
end
