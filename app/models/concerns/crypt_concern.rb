##
# This module sole purpose it to encrypt/decrypt sensitive data which stores
# in our database.
# Located in /models/concerns/crypt_concern

module CryptConcern
  extend ActiveSupport::Concern

  def crypt
    len = ActiveSupport::MessageEncryptor.key_len
    # Ensute to have a :salt key in your credentials
    # with: EDITOR='vi' bundle exec rails credentials:edit
    salt = Rails.application.credentials[:salt]
    key = ActiveSupport::KeyGenerator.new(salt).generate_key(salt, len)

    # Value of last executed line is returned
    ActiveSupport::MessageEncryptor.new(key)
  end
end
