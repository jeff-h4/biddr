class Auction < ActiveRecord::Base
  belongs_to :user
  has_many :bids, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :details, presence: true
  validates :ending_date, presence: true
  validates :reserve_price, presence: true, numericality: {greater_than: 0}

  aasm whiny_transitions: false do
    state :published, initial: true
    state :reserved_met
    state :won
    state :cancelled
    state :reserved_not_met

    event :campaign_end do
      transitions from: :published, to: [:reserved_not_met, :reserved_met, :won]
    end

    event :cancel do
      transitions from: :published, to: :cancelled
    end

  end
end
