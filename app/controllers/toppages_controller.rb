class ToppagesController < ApplicationController
  def index
    if logged_in?
      @post = current_user.posts.build
      @pagy, @posts = pagy(current_user.feed_posts.order(id: :desc), items: 24)
    end
  end
end
