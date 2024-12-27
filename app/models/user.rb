class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  has_many :tasks, foreign_key: :assignee_id

  has_many :memberships
  has_many :workspaces, through: :memberships


  def generate_otp
    self.otp_code = rand(1000..9999)
    self.otp_expries_at = 2.minutes.from_now
    save!
  end

  def check_otp(user_otp)
    self.otp_code == user_otp
  end
end
