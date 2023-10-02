class Product < ApplicationRecord
  before_validation :set_default_price

  belongs_to :supplier
  has_many :wishlist_items
  has_many :cart_items 

  validates :product_name, presence: true
  validates :description, presence: true
  validates :actual_price, presence: true


  private

  def set_default_price
    self.current_price ||= actual_price
  end
end