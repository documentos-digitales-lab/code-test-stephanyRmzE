class ChangeUnitPriceScale < ActiveRecord::Migration[7.0]
  def up
    change_column :invoice_items, :unit_price, :decimal, precision: 10, scale: 2
  end

  def down
    change_column :invoice_items, :unit_price, :decimal, precision: 10, scale: 0
  end
end
