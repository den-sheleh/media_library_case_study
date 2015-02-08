class MediaItemsController < ApplicationController
  def index
    @media_items = current_user.media_items
  end

  def new
    @media_item = MediaItem.new
  end

  def create
    @media_item = current_user.media_items.build(media_item_params)

    if @media_item.save
      redirect_to(media_item_images_path(@media_item), notice: t('media_item.success_add'))
    else
     render action: 'new'
    end
  end

  private

  def media_item_params
    params.require(:media_item).permit(:title)
  end
end
