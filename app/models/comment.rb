class Comment < ApplicationRecord
    belongs_to :post
    validates :body, presence: true
    
    belongs_to :user
end
