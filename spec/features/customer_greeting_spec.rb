require 'rails_helper'


RSpec.feature 'Customer Greeting', js: true do
  let(:customer) { create(:customer_2) }

  before do
    visit new_customer_invoice_path(customer)
  end

  it 'Gives personalized greetings', js: true do
    sleep(2)

    greeting_element = find('#name')
    expect(greeting_element).to have_content("Sheldon Quigley")
  end
end
