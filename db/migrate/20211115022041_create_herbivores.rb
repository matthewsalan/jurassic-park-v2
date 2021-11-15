class CreateHerbivores < ActiveRecord::Migration[6.1]
  def change
    create_table :herbivores do |t|
      t.string :type
      t.belongs_to :dinosaur

      t.timestamps
    end
  end
end
