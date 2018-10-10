class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.float :total_price, default: 0.0
      t.float :tax_amount, default: 0.0
      t.integer :total_amount, default: 0

      t.timestamps
    end
  end
end
