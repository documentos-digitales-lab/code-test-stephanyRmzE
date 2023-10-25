class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  validates :quantity, :product, :unit_price, presence: true
  attribute :unit_price, :decimal, precision: 10

  def amount
    quantity * unit_price
  end

end
