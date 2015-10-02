class Auction < ActiveRecord::Base
  belongs_to :user
  has_many :bids, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :details, presence: true
  validates :ending_date, presence: true
  validates :reserve_price, presence: true, numericality: {greater_than: 0}

end
