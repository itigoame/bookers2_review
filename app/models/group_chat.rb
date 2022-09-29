class GroupChat < ApplicationRecord
  belongs_to :user
  belongs_to :group

   validates :comment_text, presence: true,length: {maximum:140}
end
