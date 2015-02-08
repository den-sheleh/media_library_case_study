class CreateMediaItems < ActiveRecord::Migration
  def change
    create_table :media_items do |t|
      t.string :title
      t.references :user, index: true
      t.string :website_url
      t.string :video_url

      t.timestamps
    end
  end
end
