class AddPriceDescriptionToProcedures < ActiveRecord::Migration
  def change
    add_column :procedures, :price_description, :string
  end
end
