class JobsController < ApplicationController
  before_action :authenticate_user!

  def new
    @job = Job.new
  end

  def create
    Job.all.where(status_id: params[:job][:status_id]).each do |job|
      job.update!(status_position: job.status_position + 1)
    end
    @job = Job.new(job_params)
    @job.user_id = current_user.id
    @job.status_position = 0
    respond_to do |format|
      if @job.save!
        format.turbo_stream { render turbo_stream: turbo_stream.prepend("ul-#{params[:job][:status_id]}", partial: 'jobs/job', locals: {job: @job}) }
        format.html { redirect_to root_path, notice: "Post was successfully created." }
      else
        render 'new'
      end
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    respond_to do |format|
      if @job.update!(job_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace("li-#{@job.id}", partial: "jobs/job", locals: {job: @job}) }
        format.html { redirect_to root_path, notice: "Post was successfully updated." }
      else
        render 'edit'
      end
    end
  end

  def update_status
    @job = Job.find(params[:id])
    Job.all.where("status_position > ? ", @job.status_position).where(status_id: @job.status_id).each do |job|
      job.update!(status_position: job.status_position - 1)
    end
    Job.all.where("status_position >= ? ", params[:new_status_position].to_i).where(status_id: params[:new_status_position]).each do |job|
      puts "job: #{job}"
      job.update!(status_position: job.status_position + 1)
    end
    @job.update!(status_id: params[:new_status_id])
    @job.update!(status_position: params[:new_status_position].to_i)
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy

    redirect_to root_path
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :company_id, :url, :status_id)
  end
end
