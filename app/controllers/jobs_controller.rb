class JobsController < ApplicationController
  before_action :authenticate_user!

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.user_id = current_user.id
    if @job.save!
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])

    if @job.update(job_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def update_status
    @job = Job.find(params[:id])
    puts "--new-- #{params[:new_status_id]}"
    puts "--old-- #{params[:new_status_position]}"
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
