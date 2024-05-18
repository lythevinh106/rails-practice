class AddUserIdToOrder < ActiveRecord::Migration[7.1]
  def change
    # add_column :orders, :b, :datatype
    add_reference :orders, :user, foreign_key: true
  end
end
