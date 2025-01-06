class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  belongs_to :company

  def name
    email_address.split("@").first.capitalize
  end
end
