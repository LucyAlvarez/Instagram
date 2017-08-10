class PostsController < ApplicationController
  before_action :set_post, except: [ :index, :new, :create]

  def new
    @post = Post.new
  end

  def index
    @posts= Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  def create
    @post = Post.new(permit_post)
    if @post.save
      flash[:success] = "Success!"
      redirect_to post_path(@post)
    else
      flash[:error] = @post.errors.full_messages
      redirect_to new_post_path
    end
  end

def update
  if @post.update(permit_post)
    redirect_to :controller => "posts", :action => "index"
  else
    render :edit
  end
end


  def destroy
 @post.destroy
    redirect_to posts_path
  end

  private
  def permit_post
    params.require(:post).permit(:image, :description)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
