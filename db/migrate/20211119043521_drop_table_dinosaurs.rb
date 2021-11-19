class DropTableDinosaurs < ActiveRecord::Migration[6.1]
  def change
    drop_table :dinosaurs
  end
end
