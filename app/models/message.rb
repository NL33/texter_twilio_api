class Message < ActiveRecord::Base
 before_create :send_message

 belongs_to :user

 private
 #if create a message, the below is run
  def send_message
    begin  #meaning begin the code we want to run
      response = RestClient::Request.new(
        :method => :post,
        :url => "https://api.twilio.com/2010-04-01/Accounts/#{ENV['TWILIO_ACCOUNT_SID']}/Messages.json",
        :user => ENV['TWILIO_ACCOUNT_SID'],
        :password => ENV['TWILIO_AUTH_TOKEN'],
        :payload => { :Body => body,
                      :To => to,
                      :From => from }
      ).execute
    rescue RestClient::BadRequest => error #if there is an exception, then return false, which stops the save in active record
      message = JSON.parse(error.response)['message'] #this parses the error message, converting to a hash, and pulling out the message key of the hash
      errors.add(:base, message) #adds errors to the active record object. ":base" refers to the entire object. IF we wanted to specify something wrong with body, we would replace with ":body"
      false
    end
  end
end

