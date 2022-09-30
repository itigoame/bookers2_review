class GroupChat < ApplicationRecord
  belongs_to :user
  belongs_to :group

   validates :body, presence: true,length: {maximum:140}
end
