module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: [:show, :destroy, :update]

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
    end
  end
end
