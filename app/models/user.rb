require "digest/sha1"

class User < ActiveRecord::Base
	attr_accessor :password
	validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
	validates_length_of :password, :in => 6..20, :on => :create

	before_save :encrypt_password

	def encrypt_password
  		if password.present?
	    	self.encrypted_password = Digest::SHA1.hexdigest(password)
	    end
	end
end
