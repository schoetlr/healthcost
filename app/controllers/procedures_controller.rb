class ProceduresController < ApplicationController
  before_filter :authenticate_provider!, :except => [:index, :show, :pro_show]
  before_action :find_procedure, only: [:edit, :update, :destroy]
  before_action :authorize_resource!, except: [:index, :show, :pro_show]

 
  # GET /procedures
  # GET /procedures.json
  def correct_user
    @provider = Procedure.provider.find(params[:id])
    redirect_to(provider_path(current_provider)) unless current_provider?(@provider)
  end 

  def index
    @procedures = Procedure.all
  if params[:search]
    @procedures = Procedure.search(params[:search]).order("created_at DESC")
  else
    @procedures = Procedure.all.order('created_at DESC')
  end
end

  # GET /procedures/1
  # GET /procedures/1.json
  def show
    @procedure = Procedure.includes(:provider).find(params[:id])
  end

  def pro_show
    @code = params[:code]
    @procedures = Procedure.where(:code => @code)
  end

  # GET /procedures/new
  def new
    @provider = current_provider
    @procedure = @provider.procedures.new(params[:id])          
    respond_to do |format|
          format.html {render :new}
          format.json { head :ok}
        end
  end

  # GET /procedures/1/edit
  def edit
    @procedure = Procedure.includes(:provider).find(params[:id])
  end

  # POST /procedures
  # POST /procedures.json
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

  # PATCH/PUT /procedures/1
  # PATCH/PUT /procedures/1.json
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

  # DELETE /procedures/1
  # DELETE /procedures/1.json
  def destroy
    @procedure = Procedure.find(params[:id])
    @procedure.destroy
    respond_to do |format|
      format.html { redirect_to procedure_list_path, notice: 'Procedure was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def find_procedure
     @procedure = Procedure.find(params[:id])
   end

   def authorize_resource!
     unless current_provider == @procedure.provider
       raise Provider::NotAuthorized and return false
     end
   end

    # Never trust parameters from the scary internet, only allow the white list through.
    def procedure_params
      params.require(:procedure).permit(:name, :code, :cash_price, :insurance_price)
    end
end
