class User < ApplicationRecord
    has_secure_password
    has_one :cart
    has_one :wishlist
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :username, presence: true, uniqueness: true
    validates :password,
              length: { minimum: 6 },
              if: -> { new_record? || !password.nil? }


  after_create :create_default_cart
  after_create :create_default_wishlist

  private

  def create_default_cart
    Cart.create(user: self)
  end

  private

  def create_default_wishlist 
    Wishlist.create(user: self)
  end
end