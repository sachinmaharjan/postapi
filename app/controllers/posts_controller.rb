class PostsController < ApplicationController

  before_action :set_post, only: [:show, :update, :destroy]

  def list
    @posts = Post.all
    render json: JSON.pretty_generate(@posts.as_json), status: :ok
  end

  def show
    render json: JSON.pretty_generate(@post.as_json), status: :ok
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: JSON.pretty_generate(@post.as_json), status: :ok
    else
      render json: JSON.pretty_generate(@post.errors.as_json), status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: JSON.pretty_generate(@post.as_json), status: :ok
    else
      render json: JSON.pretty_generate(@post.errors.as_json), status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    render json: "Successfully deleted".as_json, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      begin
        @post = Post.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: "Record not found!", status: :not_found
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:id, :author, :title, :content, :user_id)
    end
end
