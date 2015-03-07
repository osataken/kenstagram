require "digest/sha1"
require "securerandom"

class User < ActiveRecord::Base
	attr_accessor :password
	validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
	validates_length_of :password, :in => 6..20, :on => :create

	before_save :encrypt_password
	before_create :set_auth_token

	private
		def encrypt_password
	  		if password.present?
		    	self.encrypted_password = Digest::SHA1.hexdigest(password)
		    end
		end

	    def set_auth_token
	      return if api_key.present?
	      self.api_key = generate_api_key
	    end

	    def generate_api_key
	      SecureRandom.uuid.gsub(/\-/,'')
	    end
end
