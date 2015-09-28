class ProvidersController < ApplicationController

	def index
      @providers = Provider.order(:created_at)
	end

	def search_by_address

      @address = params[:address]
      @providers = Provider.near(@address, 50)
      render 'providers/search_by_address'
    end

    def search_by_name
      @providers = Provider.search(params[:search])
      render 'providers/search_by_name'
    end

	def show
	  @procedures = Procedure.all
      @provider = Provider.includes(:procedure).find(params[:id])
	end

	def provider_params
		params.require(:provider).permit(:name, :address)
	end
end

