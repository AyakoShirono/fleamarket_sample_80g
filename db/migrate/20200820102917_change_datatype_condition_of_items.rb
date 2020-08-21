class ChangeDatatypeConditionOfItems < ActiveRecord::Migration[6.0]
  def change
    change_column :items, :condition, :string
  end
end
