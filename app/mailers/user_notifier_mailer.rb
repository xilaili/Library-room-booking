class UserNotifierMailer < ApplicationMailer
    layout 'mailer'
    default from: "1332731189@qq.com"
    def send_signup_email(user)
        @user = user
        mail(to: @user.email, subject: 'NCSU Libraries signup confirmation')
    end
    
    def send_reserve_email(email, booking, building)
        @email = email
        @booking = booking
        @building = building
        mail(to: booking.user_email, subject: 'NCSU Libraries room reserve confirmation')
    end
end
