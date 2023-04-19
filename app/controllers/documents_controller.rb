class DocumentsController < ApplicationController

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    @document.user = current_user
    respond_to do |format|
      if @document.save!
        format.turbo_stream { render turbo_stream: turbo_stream.after("add_doc", partial: 'documents/document', locals: {document: @document}) }
        format.html { redirect_to root_path, notice: "Document was successfully created." }
      else
        render 'new'
      end
    end
  end

  def index
    @documents = Document.all.where(user: current_user)
  end

  def edit
    @document = Document.find(params[:id])
    # io = File.open(rails_blob_path(@document.main_document))
    # @reader = PDF::Reader.new(io)
  end

  def update
    @document = Document.find(params[:id])
    @document.assign_attributes(document_params)
    respond_to do |format|
      if @document.save!
        format.turbo_stream { render turbo_stream: turbo_stream.replace("li-#{@document.id}", partial: "documents/document", locals: {document: @document}) }
        format.html { redirect_to root_path, notice: "Contact was successfully updated." }
      else
        render 'edit'
      end
    end
  end

  def destroy
    @document = Document.find(params[:id])
    respond_to do |format|
      if @document.destroy!
        format.turbo_stream { render turbo_stream: turbo_stream.remove("li-#{@document.id}") }
        format.html { redirect_to root_path, notice: "Document was successfully deleted." }
      else
        render 'edit'
      end
    end
  end

  private

  def document_params
    params.require(:document).permit(:main_document)
  end
end
