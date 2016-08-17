class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag]).order('created_at DESC').group_by{ |item| item.created_at.to_date }
    else
      @posts = Post.all.order('created_at DESC').group_by{ |item| item.created_at.to_date }
      @post = Post.new
    end
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.date = Date.today
    if @post.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
  @post = Post.find(params[:id])
  end

  private def post_params
    params.require(:post).permit(:title, :body, :tag_list)
  end

  def grouped_created_at
    @groupedPosts = @posts.group_by { |c| c.created_at.to_date }
  end

end
