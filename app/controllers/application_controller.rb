class ApplicationController < ActionController::Base
	protected

	def after_sign_in_path_for(articles)
		articles_path
	end
end
