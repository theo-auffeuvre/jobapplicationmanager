class ContactJobsController < ApplicationController

  def create
    @contactjob = ContactJob.new(contactjobs_params)
    @contact = @contactjob.contact
    respond_to do |format|
      if @contactjob.save!
        format.turbo_stream { render turbo_stream: turbo_stream.prepend("contactjobs", partial: 'contactjobs/contactjob', locals: { job: @contactjob.job }) }
        format.html { redirect_to root_path, notice: "Job was successfully added." }
      else
        render 'new'
      end
    end
  end

  def destroy
    puts params
    @contactjob = ContactJob.find(params[:id])
    @job = Job.find(@contactjob.job_id)
    respond_to do |format|
      if @contactjob.destroy!
        format.turbo_stream { render turbo_stream: turbo_stream.remove("li-#{@job.id}") }
        format.html { redirect_to root_path, notice: "Contact was successfully deleted." }
      else
        render 'edit'
      end
    end
  end

  private

  def contactjobs_params
    params.require(:contactjobs).permit(:contact_id, :job_id)
  end
end