class RemovePriceFromProcedures < ActiveRecord::Migration
  def change
  	remove_column :procedures, :price
  end
end
