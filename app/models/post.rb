class Post < ApplicationRecord
  belongs_to :user , optional: true

  require 'csv'
  require 'open-uri'
    def self.import_CSV(file, id)
        post_file =[file]
        post_file.each do |post|
            CSV.foreach(post,:headers => true) do |row|
                title = row.to_hash['title']
                description = row.to_hash['description']
                status = row.to_hash['status']
                user_id = id
                created_user_id = id 
                Post.create(title: title,description: description,status: status,user_id: user_id, created_user_id: created_user_id)
            end
        end
    end
    
end
