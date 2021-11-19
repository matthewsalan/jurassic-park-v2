class ChangeTypeColumnNameToCages < ActiveRecord::Migration[6.1]
  def change
    rename_column :cages, :type, :species_type
  end
end
