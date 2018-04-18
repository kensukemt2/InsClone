class CreateContributions < ActiveRecord::Migration[5.1]
  def change
    create_table :contributions do |t|
      t.text :caption
      t.text :image
      t.integer :user_id

      t.timestamps
    end
  end
end
