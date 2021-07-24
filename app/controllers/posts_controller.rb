class PostsController < ApplicationController
  before_action :require_user_logged_in
  
  def index
  end

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

  def edit
    @post = Post.find(params[:id])
  end

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
    @post = Post.find(params[:id])
    @post.destroy
    
    flash[:success] = '削除されました'
    redirect_to :root
  end
  
  def hashtag
    @user = current_user
    @tag = Hashtag.find_by(hash_name: params[:name])
    @posts = @tag.posts
  end
  
  def myshowcase
    @user = current_user
    @pagy, @posts = pagy(@user.posts.order(id: :desc))
  end
  
  def myhashtag
  end

  private
  
  def post_params
    params.require(:post).permit(:post_image, :get_at, :price, :comment, :hash_tag)
  end
end
