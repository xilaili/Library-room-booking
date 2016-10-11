class UserNotifierMailer < ApplicationMailer
    layout 'mailer'
    default from: "library.ncstate@gmail.com"
    def send_signup_email(user)
        @user = user
        mail(to: @user.email, subject: 'NCSU Libraries signup confirmation')
    end
    
    def send_reserve_email(email, booking)
        @email = email
        @booking = booking
        mail(to: email, subject: 'NCSU Libraries room reserve confirmation')
    end
end
