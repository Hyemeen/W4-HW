class User < ApplicationRecord

  has_many :posts
  has_many :comments
    
  RegExp = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  Phone = /\d[0-9]\)*\z/

  validates :name, presence: true, length: {maximum: 10}
  validates :phone, format: {with: Phone}, presence: true
  validates :age, numericality: {only_integer: true, greater_than: 19}, presence: true
  validates :email, format: {with: RegExp}, presence: true

end