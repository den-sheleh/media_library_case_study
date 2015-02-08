class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  has_many :media_items

  def share!
    update_attribute(:is_public, true)
  end

  def hide!
    update_attribute(:is_public, false)
  end
end
