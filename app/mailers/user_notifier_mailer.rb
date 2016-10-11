class UserNotifierMailer < ApplicationMailer
    layout 'mailer'
    default from: "lixilai0819@gmail.com"
    def send_signup_email(user)
        @user = user
        mail(to: @user.email, subject: 'NCSU Libraries room reservation')
    end
end
