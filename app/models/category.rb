class Category < ApplicationRecord
  # devise_for :users

  has_many :products, dependent: :destroy, inverse_of: :category
  validates :name, presence: { message: " tên không được để trống" }, length: { in: 6..20, message: "độ dài  tên tên phải từ  6-20" }
  scope :list_active, ->() { where(is_active: 1) }

  scope :sort_by_id, -> (query) {

    if query == "desc" || query == "asc"
      
      order(id: query)
    else
      raise ArgumentError, "query must be 'asc' or desc"
    end

  }
  scope :search_by_name, -> (search) {
    where("name LIKE ?", "%#{search}%")
  }

  def is_exits_and_equal_true
    (!self.is_active.nil? && self.is_active? && self.present?)
  end

end
