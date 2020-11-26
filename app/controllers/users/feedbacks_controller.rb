class Users::FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new(question_id: params[:id])
    @question = Question.find(params[:question_id])
  end

  def create
    @question = Question.find(params[:question_id])
    @feedback = Feedback.new(feedbacks_params)
    @feedback.user = current_user
    @feedback.question = @question
    if @feedback.save
      redirect_to users_project_path(@question.project)
    else
      render :new
    end
  end

  private

  def feedbacks_params
    params.require(:feedback).permit(:answer, :question_id)
  end
end
