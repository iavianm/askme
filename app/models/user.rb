require 'openssl'

class User < ApplicationRecord
  # Параметры работы для модуля шифрования паролей
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new
  EMAIL_REGEX = URI::MailTo::EMAIL_REGEXP
  USERNAME_REGEX = /\A[a-zA-Z0-9_]+\Z/
  COLOR_REGEX = /\A#([a-f]|[A-F]|[0-9]){3}(([a-f]|[A-F]|[0-9]){3})?\z/

  NAME_LENGTH = 40

  attr_accessor :password

  has_many :questions

  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: EMAIL_REGEX }

  validates :username,
            presence: true,
            uniqueness: true,
            format: { with: USERNAME_REGEX }

  validates :name,
            presence: true,
            length: { maximum: NAME_LENGTH }

  validates :color,
            presence: true,
            format: { with: COLOR_REGEX }

  before_validation :username_downcase, :email_downcase
  before_save :encrypt_password

  validates :password, presence: true, on: :create
  validates_confirmation_of :password

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    return nil unless user.present?

    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )
    return user if user.password_hash == hashed_password
    nil
  end

  private

  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
          password, password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
      )
    end
  end

  def username_downcase
    username&.downcase!
  end

  def email_downcase
    email&.downcase!
  end
end
