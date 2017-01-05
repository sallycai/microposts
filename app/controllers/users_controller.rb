class UsersController < ApplicationController
before_filter :logged_in_user, only: [:show, :edit, :followers, :followings]
before_filter :correct_user, only: [:edit]

  def show
  @user = User.find(params[:id])
  @microposts = @user.microposts.order(created_at: :desc).page(params[:page])
  @followers = @user.follower_users(@user).order(created_at: :desc)
  @followings = @user.following_users(@user).order(created_at: :desc)
  end
  
  def following
    @user = User.find(params[:id])
    @user = @user.following_users
    @title = "Followings"
    render 'show_follow'
    
  end
  
    def followers
    @user = User.find(params[:id])
    @user = @user.follower_users
    @title = "Followers"
    render 'show_follow'

  end
  
  def new
     @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to login_url
    else 
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
   def update
     @user = User.find params[:id]
    if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to @user, notice: 'profileを編集しました'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:id, :name, :email, :password,
                                 :password_confirmation,:location)
  end
  

end

