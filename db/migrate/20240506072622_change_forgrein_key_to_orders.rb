class ChangeForgreinKeyToOrders < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :orders, :users
    add_foreign_key :orders, :users, on_delete: :cascade
    # add_reference :orders, :user, foreign_key: true
  end
end
