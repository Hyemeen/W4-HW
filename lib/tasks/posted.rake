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

end