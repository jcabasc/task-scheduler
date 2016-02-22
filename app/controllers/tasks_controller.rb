class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def new
    @task = OpenStruct(:name, :status, :executable_path, :started_at, :ended_at, :days_of_week, :server_ids)
    @servers = Server.all.elements
  end

  def edit
    @task = Task.find(params[:id])
    @servers = Server.all.elements
  end

  def create
      task = Task.new(task_params)
      save_or_render(task: task, action: 'new')
  end

  def update
      task = Task.find(params[:id])
      save_or_render(task: task, action: 'edit')
  end

  def show
    @task = Task.find(params[:id])
  end

  def destroy
    task.destroy if task.present?
    redirect_to :tasks
  end

  private

  def save_or_render(task:, action:)
   if task.save
      flash[:notice] = 'The task was saved!'
      redirect_to action: "show", id: task.resource.id
    else
      flash[:alert] = 'The task was not saved!'
      render action.to_sym
    end
  end

  def task_params
    params.require(:task).permit(:name, :executable_path, :days_of_week, :server, :started_at, :ended_at, server_ids: [])
  end
end
