require 'rails_helper'

RSpec.describe InvoicesController, type: :controller do

  let(:customer) { create(:customer) }
  let(:invoice) { create(:invoice, customer: customer) }
  

  describe "routing" do
    it { should route(:get, '/customers/1/invoices/new').to(action: :new, customer_id: '1') }
    it { should route(:post, '/customers/1/invoices').to(action: :create, customer_id: '1') }
    it { should route(:get, '/customers/1/invoices/2').to(action: :show, customer_id: '1', id: '2') }
    it { should route(:get, '/customers/1/invoices').to(action: :index, customer_id: '1') }
  end

  describe 'GET #index' do
    it 'assigns all invoices to @invoices' do
      invoice1 = create(:invoice, customer: customer)
      invoice2 = create(:invoice, customer: customer)
      get :index, params: { customer_id: customer.to_param }

      expect(assigns(:invoices)).to match_array([invoice1, invoice2])
    end

    it 'renders the index template' do
      get :index, params: { customer_id: customer.to_param }
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'assigns a new invoice to @invoice' do
      get :new, params: { customer_id: customer.to_param }
      expect(assigns(:invoice)).to be_a_new(Invoice)
    end

    it 'assigns a new invoice item to @invoice_item' do
      get :new, params: { customer_id: customer.to_param }
      expect(assigns(:invoice).invoice_items.first).to be_a_new(InvoiceItem)
    end

    it 'renders the new template' do
      get :new, params: { customer_id: customer.to_param }
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested invoice to @invoice' do
      invoice = create(:invoice, customer: customer)
      get :show, params: { customer_id: customer.to_param, id: invoice.to_param }
      expect(assigns(:invoice)).to eq(invoice)
    end

    it 'renders the show template' do
      invoice = create(:invoice, customer: customer)
      get :show,  params: { customer_id: customer.to_param, id: invoice.to_param }
      expect(response).to render_template(:show)
    end
  end


  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new invoice' do
        invoice_params = attributes_for(:invoice)

        expect do
          post :create, params: { customer_id: customer.to_param, invoice: invoice_params }
        end.to change(Invoice, :count).by(1)
      end

      it 'redirects to the invoice show page' do
        invoice_params = attributes_for(:invoice)
        post :create, params: { customer_id: customer.to_param, invoice: invoice_params }
        expect(response).to redirect_to(customer_invoice_path(customer, Invoice.last))
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new invoice when quantity is missing in invoice_items' do
        invoice_items_attributes = [attributes_for(:invoice_item, quantity: nil)]
        invoice_params = attributes_for(:invoice).merge(invoice_items_attributes: invoice_items_attributes)
        expect do
          post :create, params: { customer_id: customer.to_param, invoice: invoice_params }
        end.not_to change(Invoice, :count)
      end
      it 'does not create a new invoice when product is missing in invoice_items' do
        invoice_items_attributes = [attributes_for(:invoice_item, product: nil)]
        invoice_params = attributes_for(:invoice).merge(invoice_items_attributes: invoice_items_attributes)
        expect do
          post :create, params: { customer_id: customer.to_param, invoice: invoice_params }
        end.not_to change(Invoice, :count)
      end
      it 'does not create a new invoice when unit_price is missing in invoice_items' do
        invoice_items_attributes = [attributes_for(:invoice_item, unit_price: nil)]
        invoice_params = attributes_for(:invoice).merge(invoice_items_attributes: invoice_items_attributes)
        expect do
          post :create, params: { customer_id: customer.to_param, invoice: invoice_params }
        end.not_to change(Invoice, :count)
      end

    end
  end


end
