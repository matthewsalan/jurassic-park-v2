class CreateCarnivores < ActiveRecord::Migration[6.1]
  def change
    create_table :carnivores do |t|
      t.string :type
      t.belongs_to :dinosaur

      t.timestamps
    end
  end
end
