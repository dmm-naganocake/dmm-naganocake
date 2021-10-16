class Address < ApplicationRecord
  belongs_to :cusomer

  validates :name, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
end
