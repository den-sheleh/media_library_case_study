class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :media_item, index: true
      t.attachment :file

      t.timestamps
    end
  end
end
