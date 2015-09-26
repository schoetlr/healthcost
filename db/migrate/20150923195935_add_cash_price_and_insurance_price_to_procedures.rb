class AddCashPriceAndInsurancePriceToProcedures < ActiveRecord::Migration
  def change
    add_column :procedures, :cash_price, :decimal
    add_column :procedures, :insurance_price, :decimal
  end
end
