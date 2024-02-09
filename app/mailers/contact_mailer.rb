class ContactMailer < ApplicationMailer
  def send_mail(contact)
    @contact = contact
    mail to: "sekiguchi.ryo@omura.co.jp", subject: '【お問い合わせ】' + @contact.subject, body: @contact.message
  end

  def auto_reply_mail(contact)
    @contact = contact
    mail to: @contact.email, subject: 'お問い合わせありがとうございます', body: '※このメールはシステムからの自動返信です'
  end
end
