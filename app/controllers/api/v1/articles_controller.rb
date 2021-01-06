module Api
    module V1
        class ArticlesController < ApplicationController
            # Root:
            def index
                articles = Article.order('created_at DESC');
                render json: {status: 'SUCCESS', message:'Loaded articles', data: articles}, status: :ok
            end

            # Get article by ID:
            def show
                article = Article.find(params[:id])
                render json: {status: 'SUCCESS', message:'Loaded article', data: article}, status: :ok
            end

            # Create article:
            def create
                article = Article.new(article_params)

                if article.save
                    render json: {status: 'SUCCESS', message:'Saved article', data: article}, status: :ok
                else
                    render json: {status: 'ERROR', message:'Failed to save article', data: article.errors}, status: :unprocessable_entity
                end
            end

            # Delete article by ID:
            def destroy
                article = Article.find(params[:id])
                article.destroy
                render json: {status: 'SUCCESS', message:'The article was successfully deleted', data: article}, status: :ok
            end

            # Edit article by ID:
            def update
                article = Article.find(params[:id])
                if article.update(article_params)
                    render json: {status: 'SUCCESS', message:'Successfully update the article', data: article}, status: :ok
                else
                    render json: {status: 'ERROR', message:'Failed to update the article', data: article.errors}, status: :unprocessable_entity
                end
            end

            private

            def article_params
                params.permit(:title, :body)
            end
        end
    end
end