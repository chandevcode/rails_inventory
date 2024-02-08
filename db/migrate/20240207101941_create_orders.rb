class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :cart, null: false, foreign_key: true
      t.decimal :total
      t.string :status

      t.timestamps
    end
    add_reference :cart_items, :order, null: true, foreign_key: true
  end
end
