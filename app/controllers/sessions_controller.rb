class SessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new;end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to root_path, notice: 'ログインに成功しました'
    else
      flash.now[:alert] = 'メールアドレスまたはパスワードが間違っています'
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other
  end
end
