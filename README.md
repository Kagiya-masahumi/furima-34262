# README

# テーブル設計

## users テーブル

| Column                | Type    | Options                      |
| --------              | ------  | -----------                  |
| nickname              | string  | null: false                  |
| email                 | string  | null: false,uniqueness: true |
| encrypted_password    | string  | null: false,uniqueness: true |
| name                  | string  | null: false                  |
| name_kana             | string  | null: false                  |
| family_name           | string  | null: false                  |
| family_name_kana      | string  | null: false                  |
| birthday              | data    | null: false                  |


### Association

- has_many :items, dependent: :destroy
- has_many :comments, dependent: :destroy
- has_many :orders



## items テーブル

| Column       | Type      | Options                        |
| --------     | ------    | -----------                    |
| item_name    | string    | null: false                    |
| status       | string    | null: false                    |
| category     | reference | null: false, foreign_key: true |
| item_explain | text      | null: false                    |
| carry_date   | integer   | null: false                    |
| postage      | integer   | null: false                    |
| price        | integer   | null: false                    |
| user         | reference | null: false, foreign_key: true |


### Association

- has_many :comments, dependent: :destroy
- has_many :item_images, dependent: :destroy
- has_many :categories, dependent: :destroy
- belongs_to :user
- has_one :order


## categories テーブル
| Column        | Type   | Options      |
| --------      | ------ | -----------  |
| category_name | string | null: false  |
| ancestry      | string |              |

### Association
- has_many :item



## item_imageテーブル
| column  | Type       | Options                        |
| ------- | ------     | -------                        |
| image   | string     | null: false                    |
| item    | references | null: false, foreign_key: true |

### Association
- belongs_to :item 



## comments テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| content | text       |                                |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

### Association

- belongs_to :item, through: :users
- belongs_to :user, through: :items



## orders テーブル

| Column      | Type       | Options                        |
| ------      | ---------- | ------------------------------ |
| user        | references | null: false, foreign_key: true |
| item        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :item
- has_many :address

## addresses テーブル

| Column      | Type       | Options                        |
| -------     | ---------- | ------------------------------ |
| postal_num  | string     | null: false                    |
| prefectures | references | null: false, foreign_key: true |
| city        | string     | null: false                    |
| address     | string     | null: false                    |
| building    | string     |                                |
| phone_num   | string     | null: false                    |
| order       | references | null: false, foreign_key: true |

### Association

- belongs_to :order
- has_one :prefecture

## prefectures テーブル
| Column      | Type       | Options                        |
| -------     | ---------- | ------------------------------ |
| prefecture  | string     | null: false                    |

- has_one :address


