class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # has_secure_password
  mount_uploader :avatar, AvatarUploader
  has_many :messages

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

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      user = User.new
      user.attributes = row.to_hash.slice(*updatable_attributes)
      user.save
    end
  end

  def self.updatable_attributes
    ["name", "email", "password"]
  end
end
