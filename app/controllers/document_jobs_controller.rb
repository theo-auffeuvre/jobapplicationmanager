class DocumentJobsController < ApplicationController

  def create
    @documentjob = DocumentJob.new(documentjobs_params)
    @document = @documentjob.document
    respond_to do |format|
      if @documentjob.save!
        format.turbo_stream { render turbo_stream: turbo_stream.prepend("documentjobs", partial: 'documentjobs/documentjob', locals: { job: @documentjob.job }) }
        format.html { redirect_to root_path, notice: "Job was successfully added." }
      else
        render 'new'
      end
    end
  end

  def destroy
    puts params
    @documentjob = DocumentJob.find(params[:id])
    @job = Job.find(@documentjob.job_id)
    respond_to do |format|
      if @documentjob.destroy!
        format.turbo_stream { render turbo_stream: turbo_stream.remove("li-#{@job.id}") }
        format.html { redirect_to root_path, notice: "document was successfully deleted." }
      else
        render 'edit'
      end
    end
  end

  private

  def documentjobs_params
    params.require(:documentjobs).permit(:document_id, :job_id)
  end
end