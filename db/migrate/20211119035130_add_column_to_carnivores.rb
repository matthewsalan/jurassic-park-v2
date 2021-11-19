class AddColumnToCarnivores < ActiveRecord::Migration[6.1]
  def change
    add_column :carnivores, :name, :string
  end
end
