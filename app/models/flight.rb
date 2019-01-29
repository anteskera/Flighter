class Flight < ApplicationRecord
  has_many :bookings, dependent: :delete_all
  belongs_to :company
  validates :name,
            uniqueness: { case_sensitive: false, scope: :company_id },
            presence: true
  validates :flys_at, presence: true
  validates :lands_at, presence: true
  validates :base_price, numericality: { greater_than: 0 }, presence: true
  validates :no_of_seats, numericality: { greater_than: 0 }, presence: true
  validate  :flys_before_landing

  def flys_before_landing
    return if flys_at && lands_at && (flys_at < lands_at)
    errors.add(:flys_at, 'must fly before landing')
  end
end
