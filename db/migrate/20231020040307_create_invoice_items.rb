class CreateInvoiceItems < ActiveRecord::Migration[7.0]
  def change
    create_table :invoice_items do |t|
      t.string :product
      t.integer :quantity
      t.decimal :unit_price
      t.references :invoice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
