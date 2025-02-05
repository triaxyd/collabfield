class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]
  has_many :posts, dependent: :destroy
  has_many :private_messages, class_name: "Private::Message"
  has_many :private_conversations,
           foreign_key: :sender_id,
           class_name: "Private::Conversation"
       def self.from_omniauth(auth)
       where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
              user.email = auth.info.email || "user-#{auth.uid}@facebook.com"
              user.password = Devise.friendly_token[0, 20]
              user.name = auth.info.name
              end
       end
end
