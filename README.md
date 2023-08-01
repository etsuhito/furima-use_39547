# DB設計
## usersテーブル
| Column | Type | Option |
|-|-|-|
| id(PK) | integer | null: false |
| nickname | string | null: false |
| email | string | null: false, unique: true |
| encrypted_password | string | null: false |
| last_name | string | null: false |
| first_name | string | null: false |
| last_name_kana | string | null: false |
| first_name_kana | string | null: false |
| date_of_birth | date | null: false |

### Association
- has_many :items
- has_many :comments

## itemsテーブル
| Column | Type | Option |
|-|-|-|
| id(PK) | integer | null: false |
| name | string | null: false |
| descritption | text | null: false |
| price | integer | null: false |
| category_id | integer | null: false |
| condition_id | integer | null: false |
| shipping_charge_id | integer | null: false |
| shipping_date_id | integer | null: false |
| prefecture_id | integer | null: false |
| user(FK) | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_many :comments
- has_one :order

## commentテーブル
| Column | Type | Option |
|-|-|-|
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |
| comment | text| 

### Association
- belongs_to :user
- belongs_to :items

## orderテーブル
| Column | Type | Option |
|-|-|-|
| user | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |

### Association
- belongs_to :items
- has_one :sending-address

## sending-addressテーブル
| Column | Type | Option |
|-|-|-|
| post_code | string | null: false |
| prefecture_id | integer | null: false |
| city | string | null: false |
| street | string | null: false |
| building_name | string | 
| phone_num | string | null: false |
| order_id | references | null: false, foreign_key: true |
| last_name | string | null: false |
| first_name | string | null: false |
| last_name_kana | string | null: false |
| first_name_kana | string | null: false |

### Association
- belongs_to :order
- has_one :credit-card

## credit-cardテーブル
| Column | Type | Option |
|-|-|-|
| user | integer | null: false |
| sending-address_id | string | null: false |
| card_id | string | null: false |
