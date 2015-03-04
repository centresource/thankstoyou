class SiteController < ApplicationController
  def index
    @post = Post.new
    @posts = Post.all.page(params[:page] || 1).per(PER_PAGE)
    @post_pages = (Post.count(:all).to_f / PER_PAGE).ceil
  end

  def read
  end

  def watch
  end
end
