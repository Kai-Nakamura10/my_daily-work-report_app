class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to reports_path, notice: 'ログインに成功しました'
    else
      flash.now[:alert] = 'メールアドレスまたはパスワードが間違っています'
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path, notice: 'ログアウトしました'
  end
end
