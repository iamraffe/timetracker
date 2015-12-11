class ProjectsController < ApplicationController
  def index
    @projects = Project.last_created_projects(10)
  end

  def new
    @project = Project.new
  end

  def show
    @project = Project.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render 'no_projects_found'
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

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    @project.update_attributes(project_params)

    redirect_to project_path(@project)
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    redirect_to projects_path
  end

  private
    def project_params
      params.require(:project).permit(:name, :description)
    end
end
