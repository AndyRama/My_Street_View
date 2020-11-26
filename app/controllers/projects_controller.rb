class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    @questions = @project.questions
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :photo)
  end
end
