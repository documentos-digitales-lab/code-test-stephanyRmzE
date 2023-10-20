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
end
