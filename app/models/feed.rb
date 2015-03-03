class Feed < ActiveRecord::Base
	belongs_to :user
	has_attached_file :attachment, styles: {
    	thumb: '100x100>',
    	square: '200x200#',
    	medium: '300x300>'
  	}

  	do_not_validate_attachment_file_type :attachment

	validates_presence_of :user
	validates :content, :presence => true
	validates :user_id, :presence => true
end
