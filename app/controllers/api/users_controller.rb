module Api
  class UsersController < ApplicationController
    # GET /users
    def index
      render json: User.all
    end

    # GET /users/:id
    def show
      user = User.find(params[:id])

      render json: user
    end

    # POST /users
    def create
      user = User.new(user_params)
      if user.save
        render json: user, status: :created
      else
        render json: { errors: user.errors }, status: :bad_request
      end
    end

    # DELETE /users
    def destroy
      user = User.find(params[:id])
      user.destroy
      head :no_content
    end

    # POST/users
    def update
      user = User.find(params[:id])
      if user.update(user_params)
        render json: user, status: :ok
      else
        render json: { errors: user.errors }, status: :bad_request
      end
    end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end
  end
end
