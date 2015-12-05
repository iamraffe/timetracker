class ProjectsController < ApplicationController
  def index
    @projects = Project.last_created_projects(10)
  end

  def new
    @project = Project.new
  end

  def show
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:notice] = "Project successfully created"
      redirect_to projects_path
    else
      redirect_to new_project_path
    end
  end

  private
    def project_params
      params.require(:project).permit(:name, :description)
    end
end
