class ImagesController < ApplicationController
  before_action :init_media_item

  def index
    @images = @media_item.images.map { |i| i.to_jq_upload }

    respond_to do |format|
      format.html
      format.json { render json: @images }
    end
  end

  def create
    @image = @media_item.images.build(image_params)

    if @image.save
      render json: { files: [@image.to_jq_upload] }, status: :created, location: media_item_images_path(@media_item, @image)
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  def destroy
    Image.find(params[:id]).destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  def init_media_item
    @media_item = current_user.media_items.find(params[:media_item_id])
  end

  def image_params
    params.require(:image).permit(:file)
  end
end
