require "digest/sha1"

class LoginController < ApplicationController
	class LoginError < StandardError; end

	# POST /login
	# POST /login.json
	def authenticate
		begin
			validate_params

			@user = User.where(username: params[:username]).take
			validate_user(@user)
			validate_password(params[:password], @user.encrypted_password)

			render json: @user, :except=>[:encrypted_password]
		rescue LoginError => e
			render json: {:error => e.message}.to_json, status: :forbidden
		end
	end

	private 
		def validate_params
			if params[:username].nil? or params[:username].to_s.empty? or
				params[:password].nil? or params[:password].to_s.empty?
				raise LoginError.new('username and password are required')
			end
		end

		def validate_user(user)
			if user.nil?
				raise LoginError.new('Invalid credentials, please input correct username and password')
			end
		end

		def validate_password(request_password, encrypted_password)

			encrypted_request_password = Digest::SHA1.hexdigest(request_password)
			if encrypted_request_password != encrypted_password
				raise LoginError.new('Invalid credentials, please input correct username and password')
			end
		end
end
