class Article < ActiveRecord::Base
  attr_accessible :title, :body, :released_at, :expired_at, :member_only

  validates :title, :body, :released_at, presence: true
  validates :title, length: { maximum: 200 }
  
  validate :check_expired_at

  private
  def check_expired_at
    if expired_at && expired_at < released_at  # 掲載終了日がnilでなく、かつ掲載開始日より古い
      errors.add(:expired_at, :expired_at_too_old)
    end
  end
end
