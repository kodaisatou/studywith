class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  has_many :favorites, dependent: :destroy
    
  validates :content, presence: true, length: {maximum: 5000}
  
end