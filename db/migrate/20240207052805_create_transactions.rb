class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :cart, null: false, foreign_key: true
      t.decimal :total_amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
