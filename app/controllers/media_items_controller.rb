class MediaItemsController < ApplicationController
  before_action :init_item, only: [:show, :edit, :update, :destroy]

  def index
    @media_items = current_user.media_items
  end

  def show
    @media_item = current_user.media_items.find(params[:id])
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

  def edit
  end

  def update
    if @media_item.update_attributes(media_item_params)
      redirect_to media_item_path(@media_item)
    else
      render action: 'edit'
    end
  end

  def destroy
    @media_item.destroy
    redirect_to root_path
  end

  private

  def media_item_params
    params.require(:media_item).permit(:title, :website_url, :video_url)
  end

  def init_item
    @media_item = current_user.media_items.find(params[:id])
  end
end
