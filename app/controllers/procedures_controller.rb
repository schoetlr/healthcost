class ProceduresController < ApplicationController
  before_filter :authenticate_provider!, :except => [:index, :show]
 
  # GET /procedures
  # GET /procedures.json
  def index
    @procedures = Procedure.search(params[:search])
    render `procedures/index`
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
    respond_to do |format|
      if @provider.procedure.update(procedure_params)
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
    def set_procedure
      @procedure = Procedure.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def procedure_params
      params.require(:procedure).permit(:name, :code, :cash_price, :insurance_price)
    end
end