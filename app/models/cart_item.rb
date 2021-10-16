class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :cusomer

  validates :amount, presence: true
end
