class ProceduresController < ApplicationController
  before_filter :authenticate_provider!, :except => [:index, :show, :pro_show]
  before_action :find_procedure, only: [:edit, :update, :destroy]
  before_action :authorize_resource!, except: [:index, :show, :pro_show, :new, :create]


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
    @provider = current_provider
    @procedure = @provider.procedures.new(procedure_params)
    @procedure.provider_id = current_provider.id


    respond_to do |format|
      if @procedure.save
        format.html { redirect_to @procedure, notice: 'Procedure was successfully created.' }
        format.json { render :show, status: :created, location: @procedure }
      else
        format.html { render :new }
        format.json { render json: @procedure.errors, status: :unprocessable_entity }
      end
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
    @procedure.destroy
    respond_to do |format|
      format.html { redirect_to procedure_list_path, notice: 'Procedure was successfully destroyed.' }
      format.json { head :no_content }
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
                                      :insurance_price)
  end
end
