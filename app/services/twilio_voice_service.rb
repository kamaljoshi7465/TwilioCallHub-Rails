require 'twilio-ruby'

class TwilioVoiceService
  def initialize
    @client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    @from_number = ENV['TWILIO_PHONE_NUMBER']
  end

  def make_call(to:, message:)
    twiml = Twilio::TwiML::VoiceResponse.new do |response|
      response.say(message: message, voice: 'alice')
    end
    
    @client.calls.create(
      from: @from_number,
      to: to,
      twiml: twiml.to_s
    )
  rescue Twilio::REST::TwilioError => e
    Rails.logger.error "Twilio Voice Error: #{e.message}"
    false
  end
end
