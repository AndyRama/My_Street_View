module Api
  module V1
    class CheckpointsController < Api::V1::BaseController
      before_action :set_checkpoint, only: [:show]
      acts_as_token_authentication_handler_for User, except: [:show]

      def index
        @checkpoints = Checkpoint.where(user: current_user).map { |point| [point.longitude, point.latitude] }
      end

      def show
      end

      def create
        @checkpoint = Checkpoint.new(checkpoint_params)
        @checkpoint.user = current_user
        if @checkpoint.save
          render :show, status: :created
        else
          render_error
        end
      end

      private

      def set_checkpoint
        @checkpoint = Checkpoint.find(params[:id])
      end

      def checkpoint_params
        params.require(:checkpoint).permit(:longitude, :latitude)
      end

      def render_error
        render json: { errors: @checkpoint.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  end
end
