
class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :title, null: false,limit:100
      t.bigint :price,null:false
      t.text :description ,null:true
      t.text :image, null: true
      t.boolean :is_active, default: true
      t.references :category ,foreign_key: { on_delete: :cascade }
      t.timestamps
    end
  end
end
