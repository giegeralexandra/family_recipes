class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :ingredients
      t.string :directions
      t.string :meal_type
      t.integer :user_id
    end
  end
end
