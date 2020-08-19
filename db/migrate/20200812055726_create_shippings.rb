class CreateShippings < ActiveRecord::Migration[6.0]
  def change
    create_table :shippings do |t|
      t.string :fee_burden, null:false
      t.string :method, null: false
      t.string :prefecture_from, null:false
      t.string :period_before_shipping, null:false
      t.references :item, foreign_key: true
      t.timestamps
    end
  end
end
