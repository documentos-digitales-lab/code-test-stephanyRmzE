# spec/features/invoice_show_spec.rb
require 'rails_helper'

RSpec.describe 'Invoice Show Page', type: :feature do
  let(:customer) { create(:customer) }

  it 'displays a message about additional tax' do
    invoice = create(:invoice, customer: customer)
    invoice_item1 = create(:invoice_item, invoice: invoice, quantity: 2, unit_price: 10)
    invoice_item2 = create(:invoice_item, invoice: invoice, quantity: 3, unit_price: 15)
    visit customer_invoice_path(customer, invoice)

    if invoice.additional_tax_required?
      expect(page).to have_content('Additional tax should be added.')
    else
      expect(page).to have_content('Additional tax is not needed.')
    end

  end

  context 'when additional tax is required' do


    it 'displays the correct message' do

      invoice = create(:invoice, customer: customer)
      invoice_item1 = create(:invoice_item, invoice: invoice, quantity: 50, unit_price: 50)
      invoice_item2 = create(:invoice_item, invoice: invoice, quantity: 20, unit_price: 1500)
      visit customer_invoice_path(customer, invoice)
      expect(page).to have_content('Additional tax should be added.')
    end
  end

  context 'when additional tax is not required' do


    it 'displays the correct message' do
      invoice = create(:invoice, customer: customer)
      invoice_item1 = create(:invoice_item, invoice: invoice, quantity: 25, unit_price: 30)
      invoice_item2 = create(:invoice_item, invoice: invoice, quantity: 10, unit_price: 25)
      visit customer_invoice_path(customer, invoice)
      expect(page).to have_content('Additional tax is not needed.')
    end
  end







end
