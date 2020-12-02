class QuestionsController < ApplicationController
  def index
    @question = @project.question
  end

  def show
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(questions_params)
      redirect_to projects_path(@project)
    else
      render :edit
    end
  end

  def edit
    @question = Question.find(params[:id])
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
