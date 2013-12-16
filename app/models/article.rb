class Article < ActiveRecord::Base
  attr_accessible :title, :body, :released_at, :expired_at, :member_only

  # ブランクでないこと（タイトル、内容、掲載開始日）
  validates :title, :body, :released_at, presence: true
 
  # 長さ（タイトル）
  validates :title, length: { maximum: 200 }
 
  # その他のチェック（掲載終了日）
  validate :check_expired_at
 
  before_validation :clear_expired_at
  
  # スコープ（レコード検索の仕方に名前を付けたもの）
  scope :readable, 
    ->{ now = Time.current
        where("released_at <= ? AND (? < expired_at OR " +
	      "expired_at IS NULL)", now, now) }

  # 掲載終了日時がブランクならtrue
  def no_expiration
    expired_at.blank?
  end

  # 引数が true、1、文字列の1のどれかなら @no_expirationをtrueに、そうでなければfalseに設定
  def no_expiration=(val)
    @no_expiration = val.in?([true, 1, "1"])
  end

  # クラスメソッド
  class << self

  # サイドバーに表示する記事の取得
    def sidebar_articles(num = 5)
      readable.order("released_at DESC").limit(num)      
    end
  end

  private
  # 掲載終了日がnilでなく、かつ掲載開始日より古いときはエラー
  def check_expired_at
    if expired_at && expired_at < released_at 
      errors.add(:expired_at, :expired_at_too_old)
    end
  end
  
  # 掲載終了日時を設定しない場合、掲載終了日にnilを設定
  def clear_expired_at
    self.expired_at = nil if @no_expiration
  end
end
