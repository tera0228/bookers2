class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # バリデーションの設定
  validates :name, uniqueness: true, length: { minimum: 2, maximum: 20}
  validates :introduction, length: { maximum: 50 }

  # アソシエーションの設定
  has_many :books, dependent: :destroy

  # プロフィール画像を使えるようにするための宣言
  has_one_attached :profile_image

  def get_profile_image
    unless profile_image.attached?
      # プロフィール画像が設定されいない場合、デフォルト画像を出力させる処理
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
      # プロフィール画像が設定されている場合の処理
      profile_image.variant(resize_to_limit: [100,100]).processed
  end

end
