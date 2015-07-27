class CommentsController < ApplicationController

	http_basic_authenticate_with name: "ddh", password: "secret", only: :destroy
	
	def new
		@comments = Comment.new
	end

	def create
		@article = Article.find(params[:article_id])
		@comment = @article.comments.create(comment_params)
		redirect_to article_path(@article)
	end

	def destroy
		@article = Article.find(params[:article_id])
		@comment = @article.comments.destroy(comment_params)
		redirect_to article_path(@article)
	end

	private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
