class VoiceCallsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    to_number = params[:to]
    message = params[:message] || 'Hello, this is a call for testing purpose'

    voice_service = TwilioVoiceService.new
    if voice_service.make_call(to: to_number, message: message)
      render json: { success: true, message: 'Call initiated successfully' }, status: :ok
    else
      render json: { success: false, message: 'Failed to initiate call' }, status: :unprocessable_entity
    end
  end
end
