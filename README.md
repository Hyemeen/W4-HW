##### 목표
레일즈를 사용하여 성인용 SNS 내의 가입 유저, 글, 댓글을 가상으로 작성한다.
<br>
##### 모델 속성 표

- User model
| name | phone | age | email |
|--------|--------|--------|------|
|  string  | string  | integer | string |
- Post model
|title|content|user_id|
|------|---|----|----|
|string|string|integer|
- Comment model
|content|id|
|-----|-----|
|integer|string|

<br>
##### 각각 모델 코드
- User.rb
```
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
```

- Post.rb
```
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
```

- Comment.rb
```
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
```

<br>
##### Schema.rb
```
ActiveRecord::Schema.define(version: 20180507093523) do

  create_table "comments", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.integer  "age"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
```
<br>
##### Task 파일
- signin.rake

```
require 'faker'

namespace :signin do

  desc "ALL"
  task all: [:twenty, :thirty, :forty, :fifty]

  desc "twenties signed in"
  task :twenty => :environment do
    (1..20).each do |a|
      User.create name: Faker::Name.unique.first_name, phone: Faker::PhoneNumber.cell_phone, age: Faker::Number.between(20, 29), email: Faker::Internet.email
    end
  end

  desc "thirties signed in"
  task :thirty => :environment do
    (1..10).each do |a|
      User.create name: Faker::Name.unique.first_name, phone: Faker::PhoneNumber.cell_phone, age: Faker::Number.between(30, 39), email: Faker::Internet.email
    end
  end

  desc "forties signed in"
  task :forty => :environment do
    (1..5).each do |a|
      User.create name: Faker::Name.unique.first_name, phone: Faker::PhoneNumber.cell_phone, age: Faker::Number.between(40, 49), email: Faker::Internet.email
    end
  end

  desc "fifties signed in"
  task :fifty => :environment do
    (1..5).each do |a|
      User.create name: Faker::Name.unique.first_name, phone: Faker::PhoneNumber.cell_phone, age: Faker::Number.between(50, 59), email: Faker::Internet.email
    end
  end
end```

- posted.rake

```
namespace :posted do

  desc "fifty_post"
   task :post => :environment do
       arr=[]
       for i in 1..40
           if User.find(i).age > 49
               arr.push(User.find(i).id)
           end
       end
       
       for j in 0..4
           Post.create title: "안녕", content: "50대입니다",
                       user_id: arr[j]
       end    
   end
end```

- Commented.rake

```
namespace :commented do

desc "forty_comment"
  task :comment => :environment do
       arr=[]
       for i in 1..40
           if User.find(i).age > 39 && User.find(i).age < 50
               arr.push(User.find(i).id)
           end
       end
       
       for j in 0..4
           Comment.create content: "댓글", user_id: arr[j], post_id: rand(1..2)
       end    
   end
end
```
<br>
##### 오류내용 + 오류 해결과정
- post와 comment에 각각 user_id와 post_id를 빼먹음 --> rd 파일에 integer로 모두 추가해주어 수정
- arr = User.age.between(50, 59)라고 선언해버림. --> 맨 처음에 arr=[]으로 배열이 있음을 선언해주고서, for문 내에서 if문으로 조건을 지어주고, 또 다시 for문으로 arr 구성을 뽑아냄 (변수가 i와 j로 두 개가 됨에 주의)
```
arr=[]
       for i in 1..40
           if User.find(i).age > 49
               arr.push(User.find(i).id)
           end
       end
```
- signin.rake에서 칼럼 명칭 사이에 쉼표를 생략하였더니 에러 발생 --> 쉼표로 서로 이어지게 배치
- post.rake에서 글이 다섯개여야 하는데 자꾸 25개 이상으로 반복되어 생김 --> arr 설정할 때 arr.push 메소드를 활용 `arr.push(User.find(i).id)`
<br>

##### 참고문서 링크
- 건대 멋사 W5 수업자료
- http://guides.rubyonrails.org/active_record_querying.html

