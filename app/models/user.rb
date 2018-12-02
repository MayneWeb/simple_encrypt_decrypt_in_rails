class User < ApplicationRecord
  # Some basic validation when we call our save method only.
  # See more: https://guides.rubyonrails.org/v3.2/active_record_validations_callbacks.html
  validates :consumer_key, presence: true, on: :save_keys
  validates :consumer_secret, presence: true, on: :save_keys

  # This is how we reuse a shared method in our rails model (crypt)
  include CryptConcern

  # HACK! We use the user model as an example. Normally you would use another model
  # in a situation like this. When a new user is created or updated,
  # this callback will get triggered
  before_save :encrypted_consumer_key_and_secret,
    if: Proc.new { |user| !user.consumer_key.nil? }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private
    def encrypted_consumer_key_and_secret
      encrypted_key = crypt.encrypt_and_sign(self.consumer_key)
      encrypted_secret = crypt.encrypt_and_sign(self.consumer_secret)
      self.consumer_key = encrypted_key
      self.consumer_secret = encrypted_secret
    end
end
