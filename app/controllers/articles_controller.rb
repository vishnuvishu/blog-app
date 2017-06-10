 class ArticlesController < ApplicationController
 	before_action :authenticate_user!, except: [:index, :show]
 	  
 	  load_and_authorize_resource

	def index
	@articles = Article.all 
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		if @article .save
			redirect_to articles_path, notice: "successfully inserted"

		else
			render action: "new"
		end
	end

	def show
		@article = Article.find(params[:id])
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])
		if @article.update_attributes(article_params)
			redirect_to article_path(@article), notice: "successfully updated"
		else
			render action: "edit"
		end
    end

    def destroy
    	@article = Article.find(params[:id])
    	if @article.destroy
    		redirect_to articles_path, notice: "successfully deleted"
    	else
    		render action: back
    	end
	end

	private

	def article_params
		params[:article].permit(:title, :body, :published, :published_date, category_ids:[])
	end
end
