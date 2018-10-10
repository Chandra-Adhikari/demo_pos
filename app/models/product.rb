class Product < ApplicationRecord

	has_many :product_tags, dependent: :destroy
	has_many :tags, through: :product_tags
	has_many :order_details, dependent: :destroy
	has_many :images, as: :imageable, dependent: :destroy
	has_many :cart_products, dependent: :destroy

	accepts_nested_attributes_for :images
	accepts_nested_attributes_for :product_tags
end
