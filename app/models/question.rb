class Question < ApplicationRecord
    #1つの質問は複数の回答を持つ
    has_many :answers, dependent: :destroy
    #1つの質問は1人のユーザーに属する
    belongs_to :user

    validates :title, presence: true, length: { maximum: 100 }
    validates :body, length: { maximum: 3000 }
end
