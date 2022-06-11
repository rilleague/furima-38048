# テーブル設計

## usersテーブル
| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birth_date         | date   | null: false               |

### association
- has_many :items
- has_many :purchases


## itemsテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| name               | string     | null: false                    |
| content            | text       | null: false                    |
| category           | string     | null: false                    |
| condition          | string     | null: false                    |
| shipping_cost      | string     | null: false                    |
| shipping_area      | string     | null: false                    |
| shipping_day       | string     | null: false                    |
| selling_price      | int        | null: false                    |
| user               | references | null: false, foreign_key: true |

### association
- belongs_to :user
- has_one :purchase


## purchasesテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user               | references | null: false, foreign_key: true |
| item               | references | null: false, foreign_key: true |

### association
- belongs_to :user
- belongs_to :item
- has_one :destination


## destinationsテーブル
| Column             | Type       | Options                         |
| ------------------ | ---------- | ------------------------------- |
| post_code          | string     | null: false                     |
| prefecture         | string     | null: false                     |
| city               | string     | null: false                     |
| street             | string     | null: false                     |
| building           | string     | null: false                     |
| phone              | string     | null: false                     |
| purchase           | references | null: false, foreign_key: true  |

### association
- belongs_to :purchase
