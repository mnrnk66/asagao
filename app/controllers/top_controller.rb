# coding: utf-8

# rails generate controller top index コマンドで作られたファイル
# TopControllerクラスと空のindexメソッド(アクション)が定義されている

class TopController < ApplicationController
  def index
    @message = "荻窪へようこそ"
  end

  def about
    @message = "武蔵境へようこそ"
  end
end
