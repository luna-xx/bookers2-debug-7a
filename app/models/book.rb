class Book < ApplicationRecord

  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_many :week_favorites, -> { where(created_at: ((Time.current.at_end_of_day - 6.day).at_deginning_of_day)..(Time.current.at_end_of_day)) }

  validates :title, presence: true
  validates :body, presence: true, length:{ maximum:200 }

  def favorited_by?(current_user)
    favorites.where(user_id: current_user.id).exists?
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Book.where('name LIKE ?', '%' + content)
    else
      Book.where('name LIKE ?', '%' + content + '%')
    end
  end

end
