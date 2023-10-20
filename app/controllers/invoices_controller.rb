class InvoicesController < ApplicationController
  before_action :set_customer, only: [:new, :create]
  before_action :set_invoice, only: [:show]


  def index
    @invoices = Invoice.all

  end
  def new

    @invoice = @customer.invoices.build
    @invoice.invoice_items.build 

  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def create

    @invoice = @customer.invoices.new(invoice_params)

    if @invoice.save
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
end
