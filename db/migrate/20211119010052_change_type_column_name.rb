class ChangeTypeColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :carnivores, :type, :species
    rename_column :herbivores, :type, :species
  end
end
