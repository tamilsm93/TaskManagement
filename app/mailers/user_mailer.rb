class UserMailer < ApplicationMailer
	default from: 'sm@gmail.com'


  def confirmation_email(user)
  	@user = user
  	mail(to: @user.email, subject: "thanxs for signup")
  end
end
