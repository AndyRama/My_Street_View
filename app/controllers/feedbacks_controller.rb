class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new(question_id: params[:id])
    @question = Question.find(params[:question_id])
  end

  def create
    @feedback = Feedback.new(feedbacks_params)
  end

  private

  def feedbacks_params
    params.require(:feedback).permit(:answer, :question_id)
  end
end
