class PostsController < ApplicationController
  before_action :authorize

  def index
    @post = Post.all.paginate(page: params[:page], per_page: 5)
   end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def confirm
    @post = Post.new(post_params)
    render 'confirmPost'
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = session[:user_id]
    @post.status = 1
    @post.created_user_id = session[:user_id]
    @post.updated_user_id = session[:user_id]
    if title_matches(@post.title) 
      redirect_to new_post_path, notice: "Title cannot be duplicated."
    else 
      if @post.save
        flash[:notice] = "Post created successfully!"
        redirect_to posts_path
      else
        flash.now.alert = "Oops, couldn't create post. "
        render :new
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
 end

 def editConfirm
  @post = Post.new(post_params)
  @post.id = params[:id] 
    puts @post.id
    puts @post.title
end

 def update
  @post = Post.find(post_params[:id])
  @post.updated_user_id = session[:user_id]
  @post.updated_at = Time.now
  if @post.update(post_params)
    redirect_to posts_path
  else
    render 'edit'
  end
end

def destroy
  @post = Post.find(params[:id])
  @post.destroy
  redirect_to posts_path
end

  def search
    if params[:search]
      @post = Post.where("#{'title'} LIKE ?" , "%#{params[:search]}")
      redirect_to posts_path, notice: "Search."
    else
      @post = Post.all
    end
  end

  def import
    file = params[:file]
    if file.blank?
      redirect_to posts_path, notice: 'Please import CSV file!'
    else
      Post.import_CSV(params[:file], session[:user_id])
      redirect_to posts_path, notice: 'Data successfully import!'
    end
  end

  def export
    @posts = Post.all
    respond_to do |format|
      format.xlsx {
        response.headers[
          'Content-Disposition'
        ] = "attachment; filename='posts.xlsx'"
      }
      format.html { render :index }
    end
  end

  private
  def post_params
    params.require(:post).permit(:id, :title, :description, :status, :create_user_id, :updated_user_id)
  end
end
