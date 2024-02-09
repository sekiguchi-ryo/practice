class Contact < ApplicationRecord

    validates :name, presence: true
    validates :email, presence: true
    validates :subject, presence: true
    validates :message, presence: true

    encrypts :name, :email, :subject, :message
end
