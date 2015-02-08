class MediaItem < ActiveRecord::Base
  belongs_to :user
  has_many :images, dependent: :destroy

  accepts_nested_attributes_for :images, allow_destroy: true

  validates :title, presence: true
  validates :website_url, format: { with: URI.regexp }, allow_blank: true
  validates :video_url, format: { with: URI.regexp }, allow_blank: true

  scope :search, ->(term) { where('title LIKE ?', "%#{term}%") }
end
