class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Invoice No. #{@invoice.id}",
               page_size: 'A4',
               template: "invoices/show.html.erb",
               layout: "pdf.html",
               orientation: "Landscape",
               lowquality: true,
               zoom: 1,
               dpi: 75
      end
    end
  end

  def new
    @invoice = Invoice.new
    @invoice.invoice_items.build
  end

  def create
    @invoice = Invoice.new(invoice_params)

    if @invoice.save
      redirect_to invoices_path
    else
      render :new
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:to_full_name, :to_street_address, :to_city, :to_state, :to_postal_code, :to_country, :to_phone_number, :status, :discount, :vat)
  end
end
