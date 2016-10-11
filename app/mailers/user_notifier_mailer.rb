class UserNotifierMailer < ApplicationMailer
    layout 'mailer'
    default from: "library.ncstate@gmail.com"
    def send_signup_email(user)
        @user = user
        mail(to: @user.email, subject: 'NCSU Libraries signup confirmation')
    end
    
    def send_reserve_email(email, booking, building)
        @email = email
        @booking = booking
        @building = building
        mail(to: email, subject: 'NCSU Libraries room reserve confirmation')
    end
end
