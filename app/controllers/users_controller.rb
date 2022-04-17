class UsersController < ApplicationController

  def show
    # 特定ユーザーの取得
    @user = User.find(params[:id])
    # 新規投稿の取得
    @book = Book.new
    # BookモデルとUserモデルのアソシエーション
    @books = Book.where(user_id: @user.id)
  end

  def index
    # ログインユーザーの取得
    @user = current_user
    # 既存ユーザーの取得
    @users = User.all
    # 新規投稿の取得
    @book = Book.new
    # 既存投稿の取得
    @books = Book.all
  end

  def edit
    # 編集対象のユーザーの取得
    @user = User.find(params[:id])
    if @user == current_user
        # 取得したユーザーがログインユーザーと一致した場合、編集画面へ遷移
        render "edit"
    else
      # 取得したユーザーがログインユーザーと一致しなかった場合、ユーザーの画面へ遷移
      redirect_to user_path(current_user)
    end
  end

  def update
    # update対象のユーザーidを選定
    @user = User.find(params[:id])
    if @user.update(user_params)
      # updateできたらフラッシュメッセージを用意
      flash[:notice]="You have updated user successfully."
      # ログイン中のユーザーの詳細ページへ遷移
      redirect_to user_path(current_user)
    else
      # updeateできなかった場合、editアクションへ
      render :edit
    end
  end

  # ストロングパラメータ
  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
