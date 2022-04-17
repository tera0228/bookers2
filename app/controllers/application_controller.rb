class ApplicationController < ActionController::Base
  # configure_permitted_parametersメソッドが実行されるための記述
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ユーザーがログインしていない場合、ログイン画面に遷移する(ただしtopアクション,aboutアクションが呼び出されたときは除く)
  before_action :authenticate_user!, except: [:top, :about]

  # サインアップの遷移先設定
  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  # ログアウト後の遷移先設定
  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  # ストロングパラメータ同様の機能
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
