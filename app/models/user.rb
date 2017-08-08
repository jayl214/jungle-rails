class User < ActiveRecord::Base

  has_secure_password

  has_many :reviews

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password, presence: true, length: { in: 6..20 }
  validates :password_confirmation, presence: true
  validates_uniqueness_of :email, :case_sensitive => false

  def self.authenticate_with_credentials(email, password)

    if email == nil || password == nil
      return nil
    end

    @user = User.where('lower(email) = lower(?)', email.strip).first

    if @user && @user.authenticate(password)
      return @user
    else
      return nil
    end

  end



end
