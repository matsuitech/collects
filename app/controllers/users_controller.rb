class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :follwings, :followeers]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @pagy, @users = pagy(User.order(id: :desc), items: 25)
    counts(current_user)
    @users = User.search(params[:search])
  end

  def show
    @user = User.find(params[:id])
    @pagy, @posts = pagy(@user.posts.order(id: :desc), items: 25)
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザーを新規登録しました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザーを新規登録できませんでした'
      render :new
    end
  end

  #def edit
  #end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = 'ユーザー情報を変更しました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザー情報を変更できませんでした'
      render :edit
    end
  end

  def destroy
    @user.destroy
    
    flash[:success] = '退会しました'
    redirect_to :root
  end
  
  def followings
    @user = User.find(params[:id])
    @pagy, @followings = pagy(@user.followings, items: 20)
    counts(@user)
    @followings = @followings.search(params[:search])
  end
  
  def followers
    @user = User.find(params[:id])
    @pagy, @followers = pagy(@user.followers, items: 20)
    counts(@user)
    @followers = @followers.search(params[:search])
  end
  
  def posts
    @user = User.find(params[:id])
    @pagy, @posts = pagy(@user.posts.order(id: :desc), items: 20)
    counts(@user)
  end
  
  def allhashtags
    @user = current_user
    @pagy, @posts = pagy(@user.posts)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :image, :password, :password_confirmation, :self_introduction)
  end
  
  def correct_user
    @user = current_user
    unless @user
      redirect_to root_url
    end
  end
end