class PostsController < ApplicationController
  before_action :is_author?, only: [:edit, :update]

  def new
    render :new
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def create
    # id_param = { user_id: current_user.id }
    @post = current_user.posts.new(post_params)
    # @post = Post.new(post_params.merge(id_param))
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  private

    def post_params
      # no longer sub_id
      params.require(:post).permit(:title, :url, :content, sub_ids: [])
    end

    def is_author?
      post = Post.find(params[:id])
      if current_user.id != post.user_id
        flash[:errors] = ["Must be the author to edit this post"]
        redirect post_url(post)
      end
    end
end
