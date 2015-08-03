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
		PrivatePub.publish_to("/articles/new", article: @article)
		@article = Article.new
	end

	def edit
		@article = Article.find(params[:id])
	end

	def create
  	@article = Article.new(article_params)
 
  	if @article.save
  		flash[:bloginfo] = "Hi #{@article.author}! your blog is created successfully"
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
		count = 0
		texlet_count = @article.text.to_s.split(" ")
		texlet_count.each {|s| count += s.length}
		if count > 20
			flash[:blogdel] = "Blog \"#{@article.text.to_s.slice(0..15)}...\" deleted successfully"
			redirect_to articles_path
		else
			c = count
			flash[:blogdel] = "Blog \"#{@article.text.to_s.slice(0..c)}\" deleted successfully"
			redirect_to articles_path
		end
	end
 
	private
  	def article_params
    	params.require(:article).permit(:author,:title, :text)
  	end
end
