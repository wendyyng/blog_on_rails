class Post < ApplicationRecord

    has_many :comments, dependent: :destroy

    belongs_to :user
    
    validates :title, presence: { message: "must be provided" }, uniqueness: true 
    validates :body, presence: { message: "must be at least 50 characters" }, length: {minimum: 50}

end
