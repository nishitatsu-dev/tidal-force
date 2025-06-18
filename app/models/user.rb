class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable,
         :omniauthable, omniauth_providers: [ :google_oauth2 ]

  has_many :sns_credentials, dependent: :destroy
  has_many :records, dependent: :destroy
  has_one :record_title, dependent: :destroy

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data["email"]).first

    unless user
      user = User.create(email: data["email"], password: Devise.friendly_token[0, 20])
      user.skip_confirmation!
    end
    user
  end
end
