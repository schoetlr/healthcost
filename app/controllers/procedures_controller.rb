class ProceduresController < ApplicationController
  before_filter :authenticate_provider!, :except => [:index, :show]
  before_action :find_procedure, only: [:edit, :update, :destroy]
  before_action :authorize_resource!, except: [:index, :show, :new, :create]


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
    @provider = current_provider
    @procedure = @provider.procedures.new(params[:id])
    respond_to do |format|
          format.html {render :new}
          format.json { head :ok}
        end
  end

  
  def edit
    @procedure = Procedure.includes(:provider).find(params[:id])
  end

  
  def create
    @procedure = @provider.procedures.new(procedure_params)
    @procedure.provider_id = current_provider.id

    if @procedure.save
      flash[:success] = 'Procedure was successfully created.' 
      redirect_to @procedure
    else
      flash[:error] = "Something went wrong."
      render :new
    end
    
  end

  
  def update
    @procedure = Procedure.includes(:provider).find(params[:id])
    respond_to do |format|
      if @procedure.update(procedure_params)
        format.html { redirect_to @procedure, notice: 'Procedure was successfully updated.' }
        format.json { render :show, status: :ok, location: @procedure }
      else
        format.html { render :edit }
        format.json { render json: @procedure.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def destroy
    @procedure = Procedure.find(params[:id])
    if @procedure.destroy
      flash[:success] = "Procedure destroyed"
      redirect_to procedure_list_path
    else
      flash[:error] = "Something went wrong"
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
                                      :insurance_price, :price_description)
  end
end
