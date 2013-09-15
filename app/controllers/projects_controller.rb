# coding: utf-8
class ProjectsController < ApplicationController
  permits :user_id, :name

  # 一覧
  def index
    @projects = Project.where(user_id: current_user.id).order(created_at: :desc)
    @project  = Project.new
  end

  # GET /projects/1/edit
  def edit(id)
    @project = Project.find_by(user_id: current_user.id, id: id)
  end

  # POST /projects
  def create(project)
    @project = Project.new(project)
    @project.user_id = current_user.id

    if @project.save
      redirect_to projects_path
    else
      render action: 'new'
    end
  end

  # PUT /projects/1
  def update(id, project)
    @project = Project.find_by(user_id: current_user.id, id: id)

    if @project.update(project)
      redirect_to projects_path
    else
      render action: 'edit'
    end
  end

  # DELETE /projects/1
  def destroy(id)
    @project = Project.find_by(user_id: current_user.id, id: id)
    @project.destroy

    redirect_to projects_url
  end
end
