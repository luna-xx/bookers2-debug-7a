class Book < ApplicationRecord

  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length:{ maximum:200 }

  def favorited_by?(current_user)
    favorites.where(user_id: current_user.id).exists?
  end

end
