class Admin::ProceduresController < ApplicationController
  def index
    if params[:search]
      @procedures = Procedure.search(params[:search]).order("created_at DESC")
    elsif params[:code]
      @procedures = Procedure.with_code(params[:code])
    else
      @procedures = Procedure.all.order('created_at DESC')
    end
  end

  
  def show
    @procedure = Procedure.includes(:provider).find(params[:id])
  end

  
  def new
    @provider = Provider.find(params[:provider_id])
    @procedure = @provider.procedures.build
    respond_to do |format|
          format.html {render :new}
          format.json { head :ok}
        end
  end

  
  def edit
    @procedure = Procedure.find(params[:id])
    @provider = Provider.find(params[:provider_id])
  end

  
  def create
    provider = Provider.find(params[:provider_id])
    @procedure = provider.procedures.build(procedure_params)
    if @procedure.save
      flash[:success] = "#{@procedure.name} successfully created for #{provider.name}"
      redirect_to new_admin_provider_procedure_path(provider)
    else
      flash[:error] = "Something went wrong creating procedure"
      render :new
    end
  end

  
  def update
    @procedure = Procedure.find(params[:id])
    provider = Provider.find(@procedure.provider_id)
      if @procedure.update(procedure_params)
        flash[:success] = "#{@procedure.name} for #{provider.name} updated"
        redirect_to admin_provider_procedures_path(provider)
      else
        flash[:error] = "Something went wrong"
        render :edit
      end
    end
  end

  
  def destroy
    @procedure = Procedure.find(params[:id])
    provider = Provider.find(@procedure.provider_id)
    if @procedure.destroy
      flash[:success] = "#{@procedure.name} destroyed for #{provider.name}"
      redirect_to admin_provider_procedures_path(provider)
    else
      flash[:error] = "Something went wrong destroying procedure"
      redirect_to :back
    end
  end

  private
    
  def find_procedure
   @procedure = Procedure.find(params[:id])
  end

  def authorize_resource!
   unless current_provider == @procedure.provider
     raise Provider::NotAuthorized and return false
   end
  end

  
  def procedure_params
    params.require(:procedure).permit(:name, :code, :cash_price, 
                                      :insurance_price, :price_description, :provider_id)
  end
end
