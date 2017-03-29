class User < ActiveRecord::Base
  validates :username, presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 25 }

  before_save { self.email = email.downcase }
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: EMAIL_REGEX},
            length: { maximum: 105 }
  # associated records should be deleted when the owner is deleted
  has_many :articles, dependent: :destroy
  has_secure_password
end