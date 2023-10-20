FactoryBot.define do
  factory :invoice_item do
    product { "MyString" }
    quantity { 1 }
    unit_price { "9.99" }
    invoice { nil}
  end
end
