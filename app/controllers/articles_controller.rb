class ArticlesController < ApplicationController

	http_basic_authenticate_with name: "Tcs", password: "secret", except: [:index, :show, :new, :create]
	
	def index
		@articles = Article.all
			@search = Article.search do
			  fulltext params[:search]			
			end
		@articles = @search.results
		if @search.results.blank?
			render 'notfound'
		end
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
  	@article = Article.new(article_params)
 
  	if @article.save
  		redirect_to @article
  	else
  		render 'new'
  	end
	end

	def update
		@article = Article.find(params[:id])

		if @article.save
			redirect_to @article
		else
			render 'edit'
		end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy

		redirect_to articles_path
	end
 
	private
  	def article_params
    	params.require(:article).permit(:author,:title, :text)
  	end
end
