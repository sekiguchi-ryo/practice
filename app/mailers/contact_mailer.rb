class ContactMailer < ApplicationMailer

    def send_mail(contact)
        @contact = contact
        mail to: "sekiguchi.ryo@omura.co.jp", subject: '【お問い合わせ】' + @contact.subject, body: @contact.message
    end
end
