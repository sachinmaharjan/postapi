class UsersController < ApplicationController
  

  def show
    begin
      @user = User.find(params[:id])
      render json: JSON.pretty_generate(@user.as_json), status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: "Record not found!", status: :not_found
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: JSON.pretty_generate(@user.as_json), status: :created
    else
      render json: JSON.pretty_generate(@user.errors.as_json), status: :unprocessable_entity
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :city)
    end
end
