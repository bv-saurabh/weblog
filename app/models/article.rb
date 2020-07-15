class Article < ApplicationRecord
	belongs_to :user
	validates :title, presence: true, length: { minimum: 5 }

	def self.create(params, current_user)
		param = { :title => params[:title], :body => params[:body], :user_id => current_user.id }
		article = Article.new(param)
	end
end
