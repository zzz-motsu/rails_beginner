class Question < ApplicationRecord
    validates :title, presence: true, length: { maximum: 100 }
    validates :body, length: { maximum: 3000 }
end
