# README

## usersテーブル
|Column    | Type   | Options              |
|----------|--------|----------------------|
|email     | string | NOT NULL ,ユニーク制約 |
|encrypted | string | NOT NULL             |
|name      | string | NOT NULL             |
|profile   | text   | NOT NULL             |
|occupation| text   | NOT NULL             |
|position  | text   | NOT NULL             |
### Association
- has_many :comments
- has_many :prototypes


# commentsテーブル
|Column   | Type       | Options           |
|---------|------------|-------------------|
|content  | text       | NOT NULL          |
|prototype| references | NOT NULL ,外部キー | 
|user     | references | NOT NULL ,外部キー |
### Association
- belongs_to :users
- belongs_to :prototypes

# prototypesテーブル
|Colmn     | Type       | Options           |
|----------|------------|-------------------|
|title     | string     | NOT NULL          |
|catch_copy| text       | NOT NULL          |
|concept   | text       | NOT NULL          |
|user      | references | NOT NULL ,外部キー |
### Association
- belongs_to :users
- has_many :comments



users-|---------------|三prototypes
   |                         |
   -                         -
   |                         |
    -----|三comments三|-------
