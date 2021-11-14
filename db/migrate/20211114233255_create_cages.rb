class CreateCages < ActiveRecord::Migration[6.1]
  def change
    create_table :cages do |t|
      t.integer :capacity, default: 10
      t.string :status
      t.string :type

      t.timestamps
    end
  end
end
