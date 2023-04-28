module Api
  module V1

      class BooksController < ApplicationController
        include ActionController::HttpAuthentication::Token
        before_action :authenticate, only: [:create, :destroy]
        def index
          books = Book.limit(limit).offset(params[:offset])
          render json: BooksRepresenter.new(books).as_json
        end

        def create
          author = Author.create!(author_params)
          book = Book.new(book_params.merge(author_id: author.id))

          if book.save
            render json: BooksRepresenter.new(Array.wrap(book)).as_json, status: :created
          else
            render json: book.errors, status: :unprocessable_entity
          end
        end
        def destroy
          book = Book.find(params[:id])
          book.destroy
          head :no_content
        rescue ActiveRecord::RecordNotFound => ex
          render json: {errors: ex}, status: :unprocessable_entity
        end
        
        private 

        def authenticate
          token, _options = token_and_options(request)
          username = AuthenticationTokenService.decode(token)
          curr  = User.find_by(username: username)
          rescue JWT::DecodeError, ActiveRecord::RecordNotFound
            render status: :unauthorized
        end

        def book_params
          params.require(:book).permit(:title)
        end

        def author_params
          params.require(:author).permit(:first_name, :last_name, :age)
        end

        def limit
          [
            params.fetch(:limit,100).to_i,
            100
          ].min
        end 

        def not_destroyed(e)
          render json: {errors: e.record.errors}, status: :unprocessable_entity
      end
    end
  end
end
