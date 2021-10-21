class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy

  attachment :image

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true

  #税込み価格の計算
  def add_tax_price
      (self.price * 1.1).round
  end
end
