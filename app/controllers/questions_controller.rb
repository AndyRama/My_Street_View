class QuestionsController < ApplicationController

  def index
    @question = @project.question
  end

  def show
  end
  
  def new
    @project = Project.find(params[:project_id])
    @question = Question.new
  end

  def create
    @project = Project.find(params[:project_id])
    @question = Question.new(question_params)
    @question.project = @project
    if @question.save
      redirect_to project_path(@project)
      #redirect_to new_users_question_feedback
    else
     render new
    end
  end

  def destroy
  end

  private
   
  def question_params
    params.require(:question).permit(:title, :first_answer, :second_answer,:photo, :project_id)
  end
end