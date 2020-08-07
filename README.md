# README

# users(ユーザー) テーブル
|Column|Type|Option|
|------|----|------|
|nickname|string|null: false|
|email|string|null: false unique: true|
|password|string|null: false|

## Association
has_many :products
has_one :profile

# profiles(本人情報) テーブル
|Column|Type|Option|
|------|----|------|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|birth_year|string|null: false|
|birth_month|string|null: false|
|birth_day|string|null: false|
|phone_number|string||
|zip_code|string|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|address|string|null: false|
|building|string||
|user_id|integer|null: false foreign_key|

## Association
belongs_to :user

# products(商品) テーブル
|Column|Type|Option|
|------|----|------|
|name|string|null: false|
|price|string|null: false|
|detail|text|null: false|
|condition|enum|null: false|
|category_id|integer|null: false foreign_key|
|brand_id|integer|null: false foreign_key|
|size_id|integer|null: false foreign_key|
|user_id|integer|null: false foreign_key|

## Association
has_many :images
belongs_to :category
belongs_to :brand
belongs_to :size
# images(商品イメージ) テーブル
|Column|Type|Option|
|------|----|------|
|url|text|null: false|
|product_id|integer|null: false foreign_key|

## Association
belongs_to :product

# cards(クレジットカード) テーブル
|Column|Type|Option|
|------|----|------|
|user_id|integer|null: false|
|customer_id|string|null: false|
|card_id|string|null: false|

## Association
belongs_to :user

# sizes(サイズ) テーブル
|Column|Type|Option|
|------|----|------|
|name|string|null: false|

## Association
has_many :products

# orders(注文情報) テーブル
|Column|Type|Option|
|------|----|------|
|product_id|integer|foreign_key null:false|
|user_id|integer|foreign_key null:false|

## Association
belongs_to :user
belongs_to :product

# categories(カテゴリー)テーブル
|Column|Type|Option|
|------|----|------|
|name|string|null: false|

## Association
has_many :products
has_ancestry

# shippings(発送) テーブル
|Column|Type|Option|
|------|----|------|
|method|integer|null: false|
|prefecture_from|integer|null: false|
|period_before_shipping|string|nul: false|
|fee_burden|boolean|null: false|

## Association
has_many :products

# brand(ブランド) テーブル
|Column|Type|Option|
|------|----|------|
|name|string|null: false|

## Association
has_many :products
