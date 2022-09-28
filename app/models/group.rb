class Group < ApplicationRecord
  has_many :group_users,                  dependent: :destroy
  has_many :users, through: :group_users, dependent: :destroy
  validates :name, presence: true
  validates :body, presence: true
  validates :group_image, presence: true

  has_one_attached :group_image
end
