class ChangeCarnivoreAssociations < ActiveRecord::Migration[6.1]
  def change
    change_table :carnivores do |t|
      t.remove :dinosaur_id
      t.belongs_to :cage
    end
  end
end
