class Company < ApplicationRecord
  has_many :flights, dependent: :nullify
  validates :name, uniqueness: { case_sensitive: false }, presence: true
end
