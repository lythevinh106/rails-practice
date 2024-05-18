class Product < ApplicationRecord
  belongs_to :category, dependent: :destroy, inverse_of: :products
  has_many :product_orders, dependent: :destroy, inverse_of: :product
  has_many :orders, through: :product_orders
  validates :title, presence: { message: " tên không được để trống" }, length: { in: 6..30, message: "độ dài  tên tên phải từ  6-30" }
  validates :description, presence: { message: " mô tả không được để trống" }, length: { in: 6..20, message: "độ dài mô tả  tên tên phải từ  6-20" }
  validates :price, presence: { message: " giá không được để trống" }, numericality: { only_integer: true, in: 0..10000, message: "giá phải nằm trong khoảng từ 0 đến 10000" }
  validates :category_id, presence: { message: " danh mục không được để trống" }
  validates :image, presence: false

  has_one_attached :image_blob, dependent: :purge_now

  scope :list_active, ->() { where(is_active: 1) }

  scope :sort_by_price, -> (query) {
    if query == "desc" || query == "asc"
      order(price: query)
    else
      raise ArgumentError, "query must be 'asc' or desc"
    end

  }
  scope :sort_by_id, -> (query) {
    if query == "desc" || query == "asc"
      order(id: query)
    else
      raise ArgumentError, "query must be 'asc' or desc"
    end

  }
  scope :search_by_title, -> (search) {

    where("title LIKE ?", "%#{search}%")
  }

  # before_update :delete_attached_image

  def is_exits_and_equal_true
    (!self.is_active.nil? && self.is_active? && self.present?)
  end

  def delete_attached_old_image(id)
    blob_to_delete = ActiveStorage::Blob.find_by(id: id)
    if persisted? && image_blob.attached? && blob_to_delete
      blob_to_delete.purge
    end

  end

end



