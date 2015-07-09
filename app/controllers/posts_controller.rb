class PostsController < ApplicationController

#before_action :authenticate_user!

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @posts = current_user.posts
    @post = @posts.new(post_params)
    
    if params[:post]
      if @post.save
        redirect_to posts_path, notice: 'Photo Uploaded'
        
      else
        render 'new'
      end
    else
      redirect_to new_post_path, alert: 'Photo Cannot Be Blank'
    end
    
  end


    def show
      @post =  Post.find(params[:id])
    end

    def edit
      @post =  Post.find(params[:id])
    end

    def update
      @post = Post.find(params[:id]) 
      @post.update(post_params) 
      redirect_to posts_path
    end

    def destroy
@post = current_user.posts.find params[:id]
    @post.destroy

    flash[:notice] = "Post deleted"
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'This is not your post!'
  ensure
    redirect_to posts_path

    end

    private

    def post_params
      params.require(:post).permit(:image) if params[:post]
    end

  end
