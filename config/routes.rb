# coding: utf-8

# rails new コマンドで作られるファイル
# ブラウザからリクエストされたパスと、それに対応するアクションを記述

Asagao::Application.routes.draw do
  root to: "top#index"  # これ以下の行はrails gで生成されたのではなく自分で記述

  get "about" => "top#about", as: "about"   # aboutアクション

  get "lesson/:action(/:name)" => "lesson"
  
  resources :members do
    collection { get "search" }          # リソースの集合を表す collectionメソッド
    member { put "suspend", "restore" }  # 個別リソースを扱う memberメソッド
  end

  resources :articles
end
