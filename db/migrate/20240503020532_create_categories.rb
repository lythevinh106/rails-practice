class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false , limit: 50
      t.boolean :is_active, default: true
      t.timestamps
    end
  end
end