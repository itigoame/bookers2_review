class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  validates :name, uniqueness: true, length:{ minimum: 2,maximum:20}
  validates :introduction, length:{ maximum: 50}


  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  # DM機能
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy

  #foreign_keyを書かないとフォローしてる情報を取ってきたいのか、されてる情報を取ってきたいのか分からないのでforeign_keyで明示する。
  has_many :followers, class_name: "Relationship",foreign_key: :follower_id, dependent: :destroy
  has_many :follower_users, through: :followers, source: :followed #自分がフォローしてる人一覧

  has_many :followings, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
  has_many :following_users, through: :followings, source: :follower #自分がフォローされてる人一覧

  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :followed_id
    # ユーザーをフォローする
  def follow(user_id)
    # current_user.follow(@user)
      # current_user.follower_users.create(followed_id: user.id)
        # @relationship = Relationship.new(relationship_params)
        # def relationship_params
          # params.require(relationship).permit(:follower_id, :followed_id)
        # end
        # @relationship.save
    followers.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    followers.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    follower_users.include?(user)
  end

  # 検索方法
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
end
