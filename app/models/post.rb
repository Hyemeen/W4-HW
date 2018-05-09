class Post < ApplicationRecord

  belongs_to :user
  has_many :comments

  words = ["fuck", "shit", "bitch"]
  
  before_save{ 
    words.each do |word| 
      len = word.length
      self.content.gsub!(/#{word}/, '*'*len) if(self.content.include?(word))
    end
  }

  validates :title, presence: true
  validates :content, presence: true

end