class AddAttachmentAttachmentToFeeds < ActiveRecord::Migration
  def self.up
    change_table :feeds do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :feeds, :attachment
  end
end
