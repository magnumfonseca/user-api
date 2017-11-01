module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: [:show, :destroy, :update]
      before_action :set_addres_id, only: [:create, :update]

      def index
        render json: User.all, adapter: :json
      end

      def create; end

      def show
        render json: @user, adapter: :json
      end

      def update; end

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
