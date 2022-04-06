class PostsController < ApplicationController
  before_action :authorize

  def index
    @post = Post.all.paginate(page: params[:page], per_page: 5)
   end

  def show
    @post = Post.find(params[:id])
  end

  def new
    if params[:option].blank?
      @post = Post.new
    else
      @post = Post.new(session[:post])
      session.delete(:post)
    end
  end

  def confirm
    @post = Post.new(post_params)
    session[:post] = post_params
    render 'confirmPost'
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = session[:user_id]
    @post.status = 1
    @post.created_user_id = session[:user_id]
    @post.updated_user_id = session[:user_id]
      if @post.save
        flash[:notice] = "Post created successfully!"
        redirect_to posts_path
      else
        flash.now.alert = "Oops, couldn't create post. "
        render :new
      end
  end

  def edit
    if params[:option].blank?
      @post = Post.find(params[:id])
    else
      @post = Post.new(session[:post])
      session.delete(:post)
    end
 end

 def editConfirm
  @post = Post.new(post_params)
  @post.id = params[:id] 
  session[:post] = post_params
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
      redirect_to posts_path
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
    respond_to do |format|
      format.html
      format.xlsx { response.headers['Content-Disposition'] = 'attachment; filename="Posts.xlsx"' }
    end
  end

  private
  def post_params
    params.require(:post).permit(:id, :title, :description, :status, :create_user_id, :updated_user_id)
  end
end
