class ChangeProfilesColumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :profiles, :birth_year, :string
    remove_column :profiles, :birth_month, :string
    remove_column :profiles, :birth_day, :string
    add_column :profiles, :birth_date, :date, null: false
  end
end
