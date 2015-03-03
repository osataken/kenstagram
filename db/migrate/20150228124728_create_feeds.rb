class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :content

      t.timestamps null: false
    end
  end
end
