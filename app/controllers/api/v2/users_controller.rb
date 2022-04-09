module Api
    module V2
        
        class UsersController < ApplicationController
        
            before_action :authenticate_user, only: [:show, :user]
        
            def create
                user = User.create(user_params)
                if user.errors.any?
                    render json: {errors: user.errors}
                else
                    login_user
                end
            end
        
            def user

            end

            def email
                user = User.exists?(email: user_params[:email])
                if user
                    render json: {status: :unauthorized, message: "Email already exists"}
                else
                    render json: {status: :ok, message: user_params[:email]}
                end

            end
        
            def show
                render json: @user
            end
        
            private

            def user_params
                params.require(:user).permit(:username, :password, :password_confirmation, :email, :first_name, :last_name)
            end
        end
    end    
end