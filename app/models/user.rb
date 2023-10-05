# == Schema Information
#
# Table name: users
#
#  id                :bigint           not null, primary key
#  active            :boolean          default(TRUE)
#  admin             :boolean          default(FALSE)
#  birthday          :date
#  email             :string
#  last_name         :string
#  last_sign_in_at   :datetime
#  name              :string
#  password_hash     :string
#  password_salt     :string
#  phone             :string
#  verification_code :integer
#  verified_account  :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email)
#
class User < ApplicationRecord
  attr_accessor :password

  scope :active, -> { where(active: true) }
  scope :admin, -> { active.where(admin: true) }
  scope :with_valid_email, -> { where.not(email: ['', nil]).where("email LIKE '%_@__%.__%'") }

  before_save :encrypt_password, :verify_phone_and_email
  before_validation { email.try(:downcase!) }

  validate :verify_email_uniqueness
  validates_confirmation_of :password
  validates_presence_of :password, on: :create
  validates_length_of :password, minimum: 4, allow_blank: true
  validates :email, presence: :true, uniqueness: { allow_blank: true }
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP, message: :not_valid, allow_blank: true

  def fullname
    "#{self.name} #{self.last_name}"
  end

  def verify_phone_and_email
    self.phone = phone.to_s.delete(' +') if phone.to_s != ''
    self.email = email.to_s.delete(" \t").downcase
  end

  def verify_email_uniqueness
    verify_phone_and_email
  end

  def valid_password?(password)
    password_hash == BCrypt::Engine.hash_secret(password, password_salt)
  end

  def encrypt_password
    return unless password.present?

    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end

  def graphql_token
    payload = { "user-id": id }
    JWT.encode(payload, ENV['JWT_SECRET_KEY'], 'HS256')
  end
end
