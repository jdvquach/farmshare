class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.text :name
      t.text :email
      t.text :password_digest
      t.text :image
      t.text :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
