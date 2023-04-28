module Api
    module V1

        class Api::V1::AuthenticationController < ApplicationController
            class AuthenticationError < StandardError; end
            rescue_from AuthenticationError, with: :handle_unauthenticated
            rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
            def create

                paramUser = params.require(:username)
                paramPassword = params.require(:password)
                user = User.find_by(username: paramUser)
                raise AuthenticationError unless user != nil
                raise AuthenticationError unless user.authenticate(paramPassword)
                token = AuthenticationTokenService.call(user.username)

                render json: {token: token}, status: :created
            end

            private 
            def handle_unauthenticated
                head :unauthorized
            end

            def handle_parameter_missing(ex)
                render json: {errors: ex.message}, status: :unprocessable_entity
            end
        end
    end
end
