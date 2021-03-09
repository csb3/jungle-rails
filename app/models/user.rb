class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, :length => {:minimum => 8}
  validates :password_digest, presence: true
  
  def self.authenticate_with_credentials(email, password)
    @user = nil
    user = User.where("LOWER(email) = ?", email.strip.downcase).first
    if user && user.authenticate(password)
      @user = user
    end
  end
end
