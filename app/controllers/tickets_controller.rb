# coding: utf-8

class TicketsController < ApplicationController
  permits :user_id, :title, :content, :status

  # GET /tickets
  def index(project_id)
    @project = Project.find_by(user_id: current_user.id, id: project_id)
    @current_tickets = Ticket.where(user_id: current_user.id, project_id: project_id, status: 'current').order(created_at: :desc)
    @backlog_tickets = Ticket.where(user_id: current_user.id, project_id: project_id, status: 'backlog').order(created_at: :desc)
    @done_tickets = Ticket.where(user_id: current_user.id, project_id: project_id, status: 'done').order(created_at: :desc)
    @ticket  = Ticket.new
  end

  # GET /tickets/1
  def show(id)
    @ticket = Ticket.find_by(user_id: current_user.id, id: id)
  end

  # GET /tickets/new
  def new(project_id)
    @ticket  = Ticket.new
    @project = Project.find_by(user_id: current_user.id, id: project_id)
  end

  # GET /tickets/1/edit
  def edit(id)
    @ticket = Ticket.find_by(user_id: current_user.id, id: id)
  end

  # POST /tickets
  def create(ticket, project_id)
    @ticket = Ticket.new(ticket)
    @ticket.user_id    = current_user.id
    @ticket.project_id = project_id

    if @ticket.save
      redirect_to tickets_path(project_id: @ticket.project_id)
    else
      render action: 'new'
    end
  end

  # PUT /tickets/1
  def update(id, ticket)
    @ticket = Ticket.find_by(user_id: current_user.id, id: id)

    if @ticket.update(ticket)
      redirect_to tickets_path(project_id: @ticket.project_id)
    else
      render action: 'edit'
    end
  end

  # ステータス変更
  def status_update(id, status)
    ticket = Ticket.find_by(user_id: current_user.id, id: id)
    ticket.status = status
    ticket.save!

    redirect_to tickets_path(project_id: ticket.project_id)
  end

  # DELETE /tickets/1
  def destroy(id)
    ticket = Ticket.find_by(user_id: current_user.id, id: id)
    ticket.destroy

    redirect_to tickets_url
  end
end
