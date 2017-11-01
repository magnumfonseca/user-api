module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: [:show, :destroy, :update]

      def index
        render json: User.all, adapter: :json
      end

      def create
        set_addres_id
        user = User.new(user_params)
        if user.save
          render json: user, adapter: :json, status: :created
        else
          render json: { error: user.errors }, status: 422
        end
      end

      def show
        render json: @user, adapter: :json
      end

      def update
        @address_id = @user.address_id
        set_addres_id if params[:user][:zipcode]
        if @user.update(user_params)
          render json: @user, adapter: :json, status: 200
        else
          render json: { error: @user.errors }, status: 422
        end
      end

      def destroy
        @user.destroy
        head :no_content
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def set_addres_id
        @address_id = AddressFinderService.find(params[:user][:zipcode])
      end

      def user_params
        params.
          require(:user).
          permit(:name, :email).
          merge(address_id: @address_id)
      end
    end
  end
end
