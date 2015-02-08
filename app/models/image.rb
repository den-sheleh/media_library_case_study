class Image < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :media_item
  validates :media_item, presence: true

  has_attached_file :file,
    path: ':rails_root/public/media_item/:id/:style/:filename',
    styles: { :medium => "500x600>", :thumb => "100x180>" },
    url: '/media_item/:id/:style/:filename'

  validates_attachment_content_type :file, content_type: /\Aimage/


  def to_jq_upload
    {
      name: file_file_name,
      size: file_file_size,
      url: file.url,
      thumbnail_url: file.url(:thumb),
      delete_url: media_item_image_path(self.media_item, self),
      delete_type: "DELETE"
    }
  end
end
