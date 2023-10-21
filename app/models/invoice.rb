class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items, dependent: :destroy

  accepts_nested_attributes_for :invoice_items, allow_destroy: true

  def sub_total
    invoice_items.sum('quantity * unit_price').to_f
  end

  def tax
    0.16 * sub_total.to_f
  end

  def total
    sub_total.to_f + tax
  end

  def additional_tax_required?
    product_1_amount = invoice_items[0].quantity * invoice_items[0].unit_price
    product_2_amount = invoice_items[1].quantity * invoice_items[1].unit_price

    product_1_amount > 2000.0 || product_2_amount > 2000.0
  end

  

end
