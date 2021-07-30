class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  #def index
  #end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      flash[:success] = 'Show Caseに並べました'
      redirect_to @post
    else
      @pagy, @posts = pagy(current_user.feed_posts.order(id: :desc))
      flash.now[:danger] = '失敗しました'
      render :new
    end
  end

  #def edit
  #end

  def update
    @post = Post.find(params[:id])
    
    if @post.update(post_params)
      flash[:success] = '編集されました'
      redirect_to @post
    else
      flash.now[:danger] = '編集されませんでした'
      render :edit
    end
  end

  def destroy
    @post.destroy
    
    flash[:success] = '削除されました'
    redirect_to myshowcase_posts_path
  end
  
  def hashtag
    @user = current_user
    @tag = Hashtag.find_by(hash_name: params[:name])
    unless @tag.nil?
      @posts = @tag.posts
    @pagy, @posts = pagy(@posts.order(id: :desc), items: 24)
    else
      redirect_to :root
    end
  end
  
  def myshowcase
    @user = current_user
    @pagy, @posts = pagy(@user.posts.order(id: :desc), items: 24)
  end
  

  private
  
  def post_params
    params.require(:post).permit(:post_image, :get_at, :price, :comment, :hash_tag)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end
