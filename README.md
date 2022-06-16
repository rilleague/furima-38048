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
| category_id        | integer    | null: false                    |
| condition_id       | integer    | null: false                    |
| shipping_cost_id   | integer    | null: false                    |
| prefecture_id      | integer    | null: false                    |
| shipping_day_id    | integer    | null: false                    |
| selling_price      | integer    | null: false                    |
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
| prefecture_id      | integer    | null: false                     |
| city               | string     | null: false                     |
| street             | string     | null: false                     |
| building           | string     |                                 |
| phone              | string     | null: false                     |
| purchase           | references | null: false, foreign_key: true  |

### association
- belongs_to :purchase

