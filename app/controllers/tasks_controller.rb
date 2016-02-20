class TasksController < ApplicationController
  expose(:task, attributes: :task_params, finder_parameter: :id)
  expose(:tasks)

  def create
      save_or_render(action: 'new')
  end

  def update
      save_or_render(action: 'edit')
  end

  def destroy
    task.destroy if task.present?
    redirect_to :tasks
  end

  private

  def save_or_render(action:)
   if task.save
      flash[:notice] = 'The task was saved!'
      redirect_to(task)
    else
      flash[:alert] = 'The task was not saved!'
      render action.to_sym
    end
  end

  def task_params
    params.require(:task).permit(:name, :executable_path, :days_of_week, :server, :started_at, :ended_at)
  end
end
