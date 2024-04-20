class User < ApplicationRecord
  has_secure_password

  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email.strip.downcase)
    # if user exist and user.authenticate return true that the hashed input password matches the database hashed pw
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password, confirmation: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true

  before_save :downcase_email
  
  private
  
  def downcase_email
    self.email = email.downcase
  end
end
