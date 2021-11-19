class CreateJoinTableDinosaurs < ActiveRecord::Migration[6.1]
  def change
    create_join_table :herbivores, :carnivores, table_name: :dinosaurs, column_options: { null: true } do |t|
      t.index [:herbivore_id, :carnivore_id]
      t.index [:carnivore_id, :herbivore_id]
    end
  end
end
