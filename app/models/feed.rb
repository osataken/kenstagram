class Feed < ActiveRecord::Base
	belongs_to :user
	has_attached_file :attachment, {
    	:url => "/:class/:attachment/:id_partition/:style/:hash",
    	:hash_secret => "kenstahash"
	}


  	do_not_validate_attachment_file_type :attachment

	validates_presence_of :user
	validates :content, :presence => true
	validates :user_id, :presence => true

	def attachment_url
		attachment.url(:medium)
	end
end
