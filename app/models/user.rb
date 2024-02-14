class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # has_secure_password
  mount_uploader :avatar, AvatarUploader

  def self.searchable_attributes
    %w[name]
  end
  searchable_attributes.each do |field|
    scope "search_by_#{field}", ->(keyword) { where("#{field} LIKE ?", "%#{keyword}%") }
  end
  def self.ransackable_attributes(auth_object = nil)
    ["name"] # 検索可能な属性名を指定
  end

  def self.ransackable_associations(auth_object = nil)
    [] # 検索可能な関連名を指定
  end
end
