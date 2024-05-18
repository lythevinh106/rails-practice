
class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.datetime :order_date, default: Time.now
      t.timestamps

    end
  end
end
