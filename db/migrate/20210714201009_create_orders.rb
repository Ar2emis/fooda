class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.integer :utc_offset, null: false
      t.integer :points, default: 0
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
