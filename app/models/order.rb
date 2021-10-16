class Order < ApplicationRecord
 has_many :order_details, dependent: :destroy
 belongs_to :customer
 
 validates :postal_code, presence: true
 validates :address, presence: true
 validates :name, presence: true
 validates :shipping_cost, presence: true
end