class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable# , :omniauthable #NOTE - 表示確認のため一旦隠す

  has_many :records, dependent: :destroy
  has_one :record_title, dependent: :destroy
end
