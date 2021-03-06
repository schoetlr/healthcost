class ProvidersController < ApplicationController
  
  before_filter :authenticate_provider!, :except => [:index, :show, :search_by_address, :search_by_name]
	
  def index
    if params[:search]
      @providers = Provider.search(params[:search]).order("created_at DESC")
    else
      @providers = Provider.all.order('created_at DESC')
    end
  end

	def search_by_address

    address = params[:address]
    @providers = Provider.near(address, 50)
    render 'providers/search_by_address'
  end

    

	def show
	  @procedures = Procedure.all
      @provider = Provider.includes(:procedures).find(params[:id])
	end

	
end

