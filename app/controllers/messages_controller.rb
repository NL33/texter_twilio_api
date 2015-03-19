class MessagesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]  #devise method: without being logged in, can only see the index and show
  
  def index 
    @messages = Message.all  
  end

  def new 
    @message = current_user.messages.build
    @user = current_user #add number to user field(? or does twilio require only specified numbers)
    if Contact.where(:id => params[:contact_id]).first 
      @contact = Contact.find(params[:contact_id])
    end
  end

  def create
    phones = message_params[:to]
    phones.each do |phone|
      contact = Contact.find_by(phone: phone)
      @message = current_user.messages.build(message_params)
      @message.to = phone 
      @message.save
    end
     if @message.errors.any?
      render 'new'
    else
      flash[:notice] = "Message sent!"
      redirect_to messages_path
    end
  end

=begin
  def show
    @message = Message.find(params[:id]) 
    render('messages/show.html.erb')
  end

  def edit 
    @message = Message.find(params[:id])
  end

  def update 
    @message = Message.find(params[:id])
    if @message.update(message_params)
     flash[:notice] = "Message updated."
      redirect_to message_path(@message)
    else
      render 'edit'
    end
  end

 def destroy 
    @message = Message.find(params[:id])
    @message.destroy
     flash[:notice] = "message Deleted"
    redirect_to messages_path
 end
=end

 private

    def message_params
      params.require(:message).permit(:to, :from, :body)
    end
end