module Users
  class ProjectsController < ApplicationController
    def index
      @projects = Project.all
      @projects.each do |project|
        progress = 2
        project.questions.each do |question|
          progress = 0 if project.progress == 2 || current_user.feedbacks.where(question_id: question) == []
        end
        project.progress += progress
      end
    end

    def show
      @project = Project.find(params[:id])
      @questions = @project.questions
      @user = current_user
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
    end

    private

    def project_params
      params.require(:project).permit(:title, :description, :photo)
    end
  end
end
