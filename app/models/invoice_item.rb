class InvoiceItem < ApplicationRecord
  belongs_to :invoice

  def amount
    quantity * unit_price
  end

end
