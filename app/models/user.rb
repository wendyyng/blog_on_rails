class User < ApplicationRecord

    has_secure_password
  
    has_many :posts, dependent: :nullify
    has_many :comments, dependent: :nullify
  
end
