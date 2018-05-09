class Comment < ApplicationRecord

  belongs_to :post
  belongs_to :user

  words = ["fuck", "shit", "bitch"]
  
  before_save{ 
    words.each do |word| 
      len = word.length
      self.content.gsub!(/#{word}/, '*'*len) if(self.content.include?(word))
    end
  }

  validates :content, presence: true, length: {maximum: 100}
end