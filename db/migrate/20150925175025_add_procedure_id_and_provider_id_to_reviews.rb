class AddProcedureIdAndProviderIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :procedure_id, :integer
    add_column :reviews, :provider_id, :integer
  end
end
