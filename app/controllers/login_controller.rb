class LoginController < ApplicationController

	# POST /login
	# POST /login.json
	def authenticate
		render json: "{'message' : 'test'}"
	end
end
