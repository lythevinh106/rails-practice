class ProductOrder < ApplicationRecord
  belongs_to :order, dependent: :destroy, inverse_of: :product_orders
  belongs_to :product, dependent: :destroy, inverse_of: :product_orders
end
