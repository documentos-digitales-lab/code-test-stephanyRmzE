class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  validates :quantity, :product, :unit_price, presence: true

  def amount
    quantity * unit_price
  end

end
