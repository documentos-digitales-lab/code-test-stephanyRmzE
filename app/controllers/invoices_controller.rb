class InvoicesController < ApplicationController
  before_action :set_customer, only: [:new, :create]
  before_action :set_invoice, only: [:show]

  require 'rest-client'



  def index
    @invoices = Invoice.all

  end
  def new
    user_id = params[:customer_id]
    url= "https://dummyjson.com/users/#{user_id}"
    response = Faraday.get(url)
    if response.success?
      @customer_data = JSON.parse(response.body)
    else
      flash[:alert] = "Failed to retrieve customer data from the API. Please try again later."
      redirect_to root_path
    end

    @invoice = @customer.invoices.build
    @invoice.invoice_items.build

  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def create

    @invoice = @customer.invoices.new(invoice_params)

    if all_items_filled_out? && @invoice.save
      redirect_to customer_invoice_path(@customer, @invoice)
    else
      render :new
    end

  end


  private

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end

  def set_invoice
    @invoice = Invoice.find(params[:id])

  end

  def invoice_params
    params.require(:invoice).permit(:customer_id, invoice_items_attributes: [:quantity, :product, :unit_price])
  end

  def all_items_filled_out?

    @invoice.invoice_items.all? do |item|
      item.quantity.present? && item.product.present? && item.unit_price.present?
    end
  end
end
