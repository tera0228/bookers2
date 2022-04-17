class Book < ApplicationRecord
  # アソシエーションの設定
  belongs_to :user

  # 新規投稿入力内容のバリデーション設定
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200}
end
