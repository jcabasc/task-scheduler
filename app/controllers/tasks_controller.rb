class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new(task_attributes)
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
      task.attributes.merge!(task_params)
      save_or_render(task: task, action: 'edit')
  end

  def show
    @task = Task.find(params[:id])
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy if @task.present?
    redirect_to action: "index"
  end

  private

  def save_or_render(task:, action:)
   if task.save
      flash[:notice] = 'The task was saved!'
      redirect_to action: "index"
    else
      flash[:alert] = 'The task was not saved!'
      render action.to_sym
    end
  end

  def task_params
    params.require(:task).permit(:name, :executable_path, :days_of_week, :started_at, :ended_at, :status, :server_ids)
  end

  def task_attributes
    {name: "", executable_path: "", days_of_week: "", started_at_int: Time.now.getutc.to_i + 1.hours, ended_at_int: Time.now.getutc.to_i + 2.hours, status: "unstarted", server_ids: []}
  end
end
