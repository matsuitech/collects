class RelationshipsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user
  
  def create
    user = User.find(params[:follow_id])
    current_user.follow(user)
    flash[:success] = 'フォローしました'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    user = User.find(params[:follow_id])
    current_user.unfollow(user)
    flash[:success] = 'フォローを外しました'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def correct_user
    @user = current_user
    unless @user
      redirect_to root_url
    end
  end
end