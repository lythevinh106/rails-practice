require 'prettyprint'

class Order < ApplicationRecord

  belongs_to :user, dependent: :destroy, inverse_of: :orders

  has_many :product_orders, dependent: :destroy, inverse_of: :order
  has_many :products, through: :product_orders

  accepts_nested_attributes_for :product_orders, allow_destroy: true
  enum status: { canceled: -1, pending: 0, success: 1 }

  validates :status, inclusion: { in: statuses.keys, message: "Trạng thái đơn hàng không hợp lệ" }
  validates :user_id, presence: { message: " user  không được để trống" }

  self.canceled
  self.success
  self.pending

  scope :sort_by_id, -> (query) {
    if query == "desc" || query == "asc"
      order(id: query)
    else
      raise ArgumentError, "query must be 'asc' or desc"
    end

  }

  scope :search_by_user_name, -> (search) {

    user_ids = User.all.where("email LIKE ?", "%#{search}%").pluck(:id)
    where(user_id: user_ids)

  }

  scope :filter_by_status, -> (status) {

    if status.in?(statuses.keys)
      where(status: status)
    else
      raise ArgumentError, "Invalid status value"
    end

  }

  scope :revenue_by_day, ->(dayParam = 1) {
    @result = select('sum(product_orders.quantity * products.price) AS total_revenue')
                .joins(:product_orders)
                .joins(:products)
                .where.not(status: Order.statuses[:canceled])
                .where(order_date: dayParam.days.ago..Time.zone.now.end_of_day)
    total_revenue = @result.first&.[](:total_revenue)
  }

  scope :number_was_sold_day, ->(dayParam = 1) {

    @result = joins(:product_orders)
                .where.not(status: Order.statuses[:canceled])
                .where(order_date: dayParam.days.ago..Time.zone.now.end_of_day)
                .sum('product_orders.quantity')

  }

  def total_price
    product_orders.joins(:product)
                  .sum { |product_order| product_order.product.price * product_order.quantity }
  end

end
