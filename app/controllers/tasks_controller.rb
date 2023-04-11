class TasksController < ApplicationController
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.job_id = params[:job_id]
    respond_to do |format|
      if @task.save!
        format.turbo_stream { render turbo_stream: turbo_stream.prepend("tasks-list", partial: 'tasks/task', locals: {task: @task}) }
        format.html { redirect_to root_path, notice: "Task was successfully created." }
      else
        render 'new'
      end
    end
  end

  def index
    @tasks = Task.all
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update!(task_params)
    respond_to do |format|
      if @task.update!(task_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace("li-#{@task.id}", partial: "tasks/task", locals: {task: @task}) }
        format.html { redirect_to root_path, notice: "Post was successfully updated." }
      else
        render 'edit'
      end
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to job_path(params[:job_id])
  end

  private

  def task_params
    params.require(:task).permit(:title, :starts_at, :ends_at, :note, :task_status)
  end

end
