class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items, dependent: :destroy 

  accepts_nested_attributes_for :invoice_items, reject_if: :all_blank, allow_destroy: true

  def sub_total
    invoice_items.sum('quantity * unit_price')
  end

  def tax
    0.16 * sub_total
  end

  def total
    sub_total + tax
  end
end
