class Image < ActiveRecord::Base
  belongs_to :media_item
  validates :media_item, presence: true

  has_attached_file :file,
    path: ':rails_root/public/media_item/:id/:style/:filename',
    styles: { :medium => "500x600>", :thumb => "100x180>" },
    url: '/media_item/:id/:style/:filename'

  validates_attachment_content_type :file, content_type: /\Aimage/
end
