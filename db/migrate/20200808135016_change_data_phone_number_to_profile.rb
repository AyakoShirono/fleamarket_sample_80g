class ChangeDataPhoneNumberToProfile < ActiveRecord::Migration[6.0]
  def change
    change_column :profiles, :phone_number, :string
  end
end
