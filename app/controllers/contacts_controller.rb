class ContactsController < ApplicationController
  before_filter :authenticate_user!
 
  def index 
    @contacts = Contact.all
    @user = current_user
    #if params[:query]
     # @searched_contacts = Contact.basic_search(params[:query])
    #end
  end

  def new 
    @contact = current_user.contacts.new
  end

  def create
    @contacts = Contact.all
    @contact = current_user.contacts.new(contact_params)
    if @contact.save
        flash[:notice] = "Contact created."
        redirect_to contacts_path
      else
        render 'new' 
      end
  end

=begin
  def edit  
    if User.find(params[:user_id]) != current_user
      flash[:notice] = "You are not permitted to edit this contact"
      redirect_to root_path
    else
      @user = current_user
      @contact = Contact.find(params[:id])
    end
  end

  def update 
    @contact = Contact.find(params[:id])
    @contacts = contact.contacts
    

    @contact.update(contact_params)
     flash[:notice] = "Contact Updated"
    redirect_to root_path
  end

 def destroy 
    @contact = Contact.find(params[:id])
    @contact.destroy
     flash[:notice] = "Contact Deleted"
    redirect_to root_path
 end
=end
 
 private

    def contact_params
      params.require(:contact).permit(:name, :number)
    end

end