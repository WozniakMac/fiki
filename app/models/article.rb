class Article < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true
  validates :user_id, presence: true

  def self.search(term)
    if term
      where('title LIKE ? OR language like ?', "%#{term}%", "%#{term}%")
    else
      all
    end
  end
end
