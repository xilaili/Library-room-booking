class UserNotifierMailer < ApplicationMailer
    layout 'mailer'
    default from: "library.ncstate@gmail.com"
    def send_signup_email(user)
        @user = user
        mail(to: @user.email, subject: 'NCSU Libraries room reservation')
    end
end
