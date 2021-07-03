class ToppagesController < ApplicationController
  def index
    if logged_in?
      @pagy, @posts = pagy(Post.order(id: :desc))
    end
  end
end
