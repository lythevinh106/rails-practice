class CreateProductOrders  < ActiveRecord::Migration[7.1]
  def change
    create_table :product_orders do |t|
      t.integer  :quantity
      t.references :product ,foreign_key: { on_delete: :cascade }
      t.references :order ,foreign_key: { on_delete: :cascade }
      t.timestamps
    end
  end
end