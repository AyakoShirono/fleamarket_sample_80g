class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :first_name_kana, null: false
      t.string :last_name_kana, null: false
      t.string :birth_year, null: false
      t.string :birth_month, null: false
      t.string :birth_day, null: false
      t.integer :phone_number
      t.string :zip_code, null: false
      t.string :prefecture, null: false
      t.string :city, null: false
      t.string :address, null: false
      t.string :building
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
