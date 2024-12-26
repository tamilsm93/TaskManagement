class AddOtpToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :otp_code, :string
    add_column :users, :otp_expries_at, :datetime
  end
end
