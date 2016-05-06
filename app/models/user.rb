class User < ActiveRecord::Base

  before_create :remember
  has_many :posts

  validates :username,  presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, allow_nil: true

  has_secure_password

  def User.digest(string)
    Digest::SHA1.hexdigest(string)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.digest(User.new_token)
  end

end
