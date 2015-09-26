class AddProviderIdToProcedures < ActiveRecord::Migration
  def change
    add_column :procedures, :provider_id, :integer
  end
end
