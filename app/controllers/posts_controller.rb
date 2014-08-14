class PostsController < ApplicationController

  def create
    @post = current_user.posts.create(posts_params)

    if @post.save
      if (!@post.user.met_how)
        redirect_to profile_path, :notice => "Thanks for the post! Would you mind updating your profile to help describe how/when you met Steve, and where you currently live?"
      else
        redirect_to post_path(@post.id), :notice => "Thanks for the post!"
      end
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(posts_params)
      redirect_to :root, notice: 'Your post was successfully updated.'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def get_ajax
    @posts = Post.all.page(params[:page] || 1).per(PER_PAGE)
    render layout: false
  end

  private

    def posts_params
      params.require(:post).permit(:title, :body, :image)
    end
end
