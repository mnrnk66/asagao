class Member < ActiveRecord::Base
  # 教本の便利モジュールをミックスイン
  include EmailAddressChecker

  # attr_accessible :title, :body
  attr_accessible :id, :number, :name, :full_name, :email, :birthday, :gender, :administrator

  # クラスメソッド
  class << self
    def search(query)
      rel = order("number")
      if query.present?
        rel = rel.where("name LIKE ? OR full_name LIKE ?",
	        "%#{query}%", "%#{query}%")
      end
      rel
    end
  
  end

  # 会員情報の検証
  validates :number, presence: true,
    numericality: { only_integer: true,
       greater_than: 0, less_than: 100, allow_blank: true },
    uniqueness: true
  
  validates :name, presence: true,
    format: { with: /\A[A-Za-z]\w*\z/, allow_blank: true,
              message: :invalid_member_name },               # config/locales/ja.yml で定義したメッセージを使う
    length: { minimum: 2, maximum: 20, allow_blank: true },
    uniqueness: true

  validates :full_name, length: { maximum: 20 }

  validate :check_email

  private
  def check_email
    if email.present?
      errors.add(:email, :invalid) unless
          well_formed_as_email_address(email)
    end
  end
end
