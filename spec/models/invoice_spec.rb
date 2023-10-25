require 'rails_helper'

RSpec.describe Invoice, type: :model do
  let(:customer) { create(:customer) }
  let(:invoice) { create(:invoice, customer: customer) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      invoice = build(:invoice, customer: customer)
      expect(invoice).to be_valid
    end

    it 'is not valid without a customer' do
      invoice = build(:invoice, customer: nil)
      expect(invoice).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a customer' do
      association = described_class.reflect_on_association(:customer)
      expect(association.macro).to eq :belongs_to
    end

    it 'has many invoice items' do
      association = described_class.reflect_on_association(:invoice_items)
      expect(association.macro).to eq :has_many
    end

    it 'destroys associated invoice items' do
      invoice = create(:invoice, customer: customer)
      invoice_item = create(:invoice_item, invoice: invoice)
      expect { invoice.destroy }.to change(InvoiceItem, :count).by(-1)
    end

    # Add more association tests as needed
  end

  describe 'methods' do
    it '#sub_total calculates the sub-total correctly' do
      invoice = create(:invoice, customer: customer)
      invoice_item1 = create(:invoice_item, invoice: invoice, quantity: 2, unit_price: 10)
      invoice_item2 = create(:invoice_item, invoice: invoice, quantity: 3, unit_price: 15)

      expect(invoice.sub_total).to eq(2 * 10 + 3 * 15)
    end

    it '#tax calculates the tax correctly' do
      invoice = create(:invoice, customer: customer)
      invoice_item1 = create(:invoice_item, invoice: invoice, quantity: 2, unit_price: 10)
      invoice_item2 = create(:invoice_item, invoice: invoice, quantity: 3, unit_price: 15)

      expect(invoice.tax).to eq(0.16 * (2 * 10 + 3 * 15))
    end

    it '#total calculates the total correctly' do
      invoice = create(:invoice, customer: customer)
      invoice_item1 = create(:invoice_item, invoice: invoice, quantity: 2, unit_price: 10)
      invoice_item2 = create(:invoice_item, invoice: invoice, quantity: 3, unit_price: 15)

      expect(invoice.total).to be_within(0.01).of(1.16 * (2 * 10 + 3 * 15))
    end

    describe '#additional_tax_required?' do
      it 'returns true if any product amount exceeds $2,000.00' do
        invoice = create(:invoice, customer: customer)
        invoice_item1 = create(:invoice_item, invoice: invoice, quantity: 50, unit_price: 50)
        invoice_item2 = create(:invoice_item, invoice: invoice, quantity: 20, unit_price: 1500)
        expect(invoice.additional_tax_required?).to be(true)
      end

      it 'returns false if no product amount exceeds $2,000.00' do
        invoice = create(:invoice, customer: customer)
        invoice_item1 = create(:invoice_item, invoice: invoice, quantity: 25, unit_price: 30)
        invoice_item2 = create(:invoice_item, invoice: invoice, quantity: 10, unit_price: 25)
        expect(invoice.additional_tax_required?).to be(false)
      end
    end
  end

end
