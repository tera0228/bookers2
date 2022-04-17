Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # トップ画面を'/'で呼べる設定
  root to: "homes#top"

  # 'home/about画面の取得'
  get 'home/about' => "homes#about"

  # ユーザーとブックのリソース設定
  resources :users
  resources :books
end
