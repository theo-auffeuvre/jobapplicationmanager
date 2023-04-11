class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @company = Company.where(name: params[:contact][:company_id]).first_or_create(logo_url: params[:contact][:logo_url])
    @contact = Contact.new(contact_params)
    @contact.user = current_user
    @contact.company_id = @company.id
    respond_to do |format|
      if @contact.save!
        format.turbo_stream { render turbo_stream: turbo_stream.prepend("contacts", partial: 'contacts/contact', locals: {contact: @contact}) }
        format.html { redirect_to root_path, notice: "Contact was successfully created." }
      else
        render 'new'
      end
    end
  end

  def index
    @contacts = Contact.all.where(user: current_user)
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def update
    @company = Company.where(name: params[:contact][:company_id]).first_or_create(logo_url: params[:contact][:logo_url])
    @contact = Contact.find(params[:id])
    @contact.assign_attributes(contact_params)
    @contact.company_id = @company.id
    respond_to do |format|
      if @contact.save!
        format.turbo_stream { render turbo_stream: turbo_stream.replace("li-#{@contact.id}", partial: "contacts/contact", locals: {contact: @contact}) }
        format.html { redirect_to root_path, notice: "Contact was successfully updated." }
      else
        render 'edit'
      end
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    redirect_to contacts_path
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :location, :email, :phone, :company, :job_title, :user_id)
  end
end
