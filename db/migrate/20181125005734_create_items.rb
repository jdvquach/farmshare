class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.text :summary
      t.text :description
      t.text :item_image
      t.integer :qty
      t.float :latitude
      t.float :longitude
      t.text :address
      t.integer :category_id

      t.timestamps
    end
  end
end
