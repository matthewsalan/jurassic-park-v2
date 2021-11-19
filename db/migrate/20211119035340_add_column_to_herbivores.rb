class AddColumnToHerbivores < ActiveRecord::Migration[6.1]
  def change
    add_column :herbivores, :name, :string
  end
end
