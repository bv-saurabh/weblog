class ArticlesController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@articles = Article.all
	end

	def show
		@article = Article.find(params[:id])
	end

	def new
		@article = Article.new
	end

	def edit
		@article = Article.find(params[:id])
	end

	def create
		@article = Article.create(params[:article], current_user)
		if @article.save
			redirect_to @article
		else
			render 'new'
		end
	end

	def update
		@article = Article.find(params[:id])
		if @article.user_id == current_user.id
			if @article.update!({ :title => params[:article][:title], :body => params[:article][:body] })
				redirect_to @article
			else
				render 'edit'
			end
		else
			redirect_to '/articles', notice: "You are not allowed to edit other user's posts!"
		end
	end

	def destroy
		@article = Article.find(params[:id])
		if @article.user_id == current_user.id
			@article.destroy
			redirect_to articles_path
		else
			redirect_to '/articles', notice: "You are not allowed to delete other user's posts!"
		end
	end
end
