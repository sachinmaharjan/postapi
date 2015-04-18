class ImagesController < ApplicationController


  def create
    @image = Image.new(image_params)
    if @image.save
      render json: JSON.pretty_generate(@image.as_json), status: :created
    else
      render json: JSON.pretty_generate(@image.errors.as_json), status: :unprocessable_entity
    end
  end

  def destroy
    begin
      @image = Image.find(params[:id])
      @image.destroy
      render json: "Successfully deleted".as_json, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: "Record not found!".as_json, status: :not_found
    end
  end

  private

    def image_params
      params.require(:image).permit(:id, :post_id, :path)
    end
end
