class User < ApplicationRecord
  has_many :bookings, dependent: :delete_all
  validates :first_name,
            length: { minimum: 2 },
            presence: true
  validates :email, uniqueness: { case_sensitive: false },
                    format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/,
                    presence: true
end
