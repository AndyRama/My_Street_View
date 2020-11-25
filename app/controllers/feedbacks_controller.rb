class FeedbacksController < ApplicationController
  def new
  end

  def create
  end

  private

  def feedbacks_params
    params.require(:feedback).permit(:answer, :question_id)
  end
end
