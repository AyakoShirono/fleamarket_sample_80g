class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.text :image   #一覧表示のための仮カラムです、imageテーブルを作ったらこのカラムは削除してください
      t.string :name, null:false
      t.string :price, null:false
      t.text :detail, null:false
      t.integer :condition, null:false   #modelでenum設定が必要
      t.integer :category_id, null:false, foreign_key: true
      t.integer :brand_id,  null:false, foreign_key: true
      t.integer :size_id, null:false, foreign_key: true
      t.integer :user_id, null:false, foreign_key: true
      t.timestamps
    end
  end
end
