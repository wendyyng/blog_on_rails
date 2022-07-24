class User < ApplicationRecord

    has_secure_password
        validates(:email, presence: true, uniqueness: true, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
        # validates(:password, presence: true, length: { in: 3..20 })
        validates(:name, presence: true, length: { in: 2..20 })
        
  
    has_many :posts, dependent: :nullify
    has_many :comments, dependent: :nullify
  
end
