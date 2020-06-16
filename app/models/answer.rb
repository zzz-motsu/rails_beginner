class Answer < ApplicationRecord
    #1つの回答は1人のユーザーに属する
    belongs_to :user
    #1つの回答は1つの質問に属する
    belongs_to :question

    validates :body, presence: true, length: { maximum: 1000 }
end
