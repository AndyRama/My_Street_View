class QuestionsController < ApplicationController
  def index
    @question = @project.question
  end

  def show
  end

  def edit
    # @project = Project.find(params[:id])
    # if @project.save
    #   redirect_to projects_path(@project)
    # else
    #   redirect_to edit_question_path(@project)
    # end
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
