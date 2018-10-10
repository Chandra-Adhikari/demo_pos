class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    has_many :orders,dependent: :destroy
    has_many :cart_products, dependent: :destroy
    has_one :image, as: :imageable, dependent: :destroy
    has_many :cart_products, dependent: :destroy
end
