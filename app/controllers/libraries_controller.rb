class LibrariesController < ApplicationController
  def show
    @media_library = User.find(params[:id])

    if @media_library.is_public? || @media_library == current_user
      @media_items = @media_library.media_items
      render 'media_items/index'
    else
      redirect_to root_path, alert: I18n.t('library.forbidden')
    end
  end

  def share
    current_user.share!
    redirect_to root_path
  end

  def hide
    current_user.hide!
    redirect_to root_path
  end
end
