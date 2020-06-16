class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  #１人のユーザーは多くの質問を持つ(1対多の関係)
  has_many :questions, dependent: :destroy
  #１人のユーザーは多くの回答を持つ(1対多の関係)
  has_many :answers, dependent: :destroy
end