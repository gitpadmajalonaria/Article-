class Note < ApplicationRecord

  belongs_to :user
  has_one_attached :image

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def liked?(user)
    !!self.likes.find{|like| like.user_id == user.id}
  end

end
