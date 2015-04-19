class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]

  # def index
  #   @comments = Comment.hash_tree
  # end

  def list
    @comments = Comment.where(post_id: params[:post_id])
    render json: JSON.pretty_generate(@comments.as_json), status: :ok
  end

  def create
    if params[:comment][:parent_id].to_i > 0
      parent = Comment.find_by_id(params[:comment].delete(:parent_id))
      ap parent
      ap parent.children
      @comment = parent.children.build(comment_params)
    else
      @comment = Comment.new(comment_params)
    end
    if @comment.save
      render json: JSON.pretty_generate(@comment.as_json), status: :created
    else
      render json: JSON.pretty_generate(@comment.errors.as_json), status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    render json: "Successfully deleted".as_json, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      begin
        @comment = Comment.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: "Record not found!", status: :not_found
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:post_id, :user_id, :parent_id, :message, :deleted)
    end
end
