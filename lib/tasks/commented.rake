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