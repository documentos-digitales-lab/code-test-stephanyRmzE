require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  let(:customer) { create(:customer) }
  let(:invoice) { create(:invoice, customer: customer) }
  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:product) }
    it { should validate_presence_of(:unit_price) }
  end

  describe '#amount' do
    it 'calculates the correct amount' do
      invoice_item = create(:invoice_item, invoice: invoice, quantity: 3, unit_price: 10)

      expect(invoice_item.amount).to eq(30) # 3 * 10
    end
  end
end
