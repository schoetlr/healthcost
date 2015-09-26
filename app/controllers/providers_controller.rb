class ProvidersController < ApplicationController

	def index
      @providers = Provider.all
	end



	def provider_params
		params.require(:provider).permit(:name)
	end
end
