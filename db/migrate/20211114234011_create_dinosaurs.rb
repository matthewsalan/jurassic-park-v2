class CreateDinosaurs < ActiveRecord::Migration[6.1]
  def change
    create_table :dinosaurs do |t|
      t.string 'name'
      t.belongs_to :cage

      t.timestamps
    end
  end
end
