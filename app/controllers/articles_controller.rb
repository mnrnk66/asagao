class ArticlesController < ApplicationController
  # ニュース一覧
  def index
    @articles = Article.order("released_at DESC")
  end

  # ニュース詳細
  def show
    @article = Article.find(params[:id])
  end

  # 新規登録フォーム
  def new
    @article = Article.new
  end

  # 編集フォーム
  def edit
    @article = Article.find(params[:id])
  end

end
