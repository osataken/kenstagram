class AddFeedsToUser < ActiveRecord::Migration
  def change
  	add_reference :feeds, :user, index: true
  end
end
