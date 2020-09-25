class AddressesController < ApplicationController
  
  def index
    @contact = Contact.find(params[:contact_id])
    @addresses = Address.all
    @address = Address.new
  end

  def new
    @contact = Contact.find(params[:contact_id])
    @address = Address.new
  end
  
  def edit
    @contact = Contact.find(params[:contact_id])
    @address = @contact.addresses.find(params[:id])
  end

  def create
    @contact = Contact.find(params[:contact_id])
    @address = @contact.addresses.create(address_params)
    redirect_to contact_addresses_path(@contact)
  end

  def update
    @contact = Contact.find(params[:contact_id])
    @address = @contact.addresses.find(params[:id])

    if @address.update(address_params)
      redirect_to contact_addresses_path(@contact), notice: "Saved!"
    else
      render 'edit'
    end
  end

  def destroy
    @contact = Contact.find(params[:contact_id])
    @address = @contact.addresses.find(params[:id])
    @address.destroy
    redirect_to contact_addresses_path(@contact)
  end

  private
    def address_params
      params.require(:address).permit(:street, :town, :zip, :state, :country)
    end
end