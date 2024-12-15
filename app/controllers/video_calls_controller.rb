class VideoCallsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    identity = params[:identity] || "user_#{SecureRandom.hex(4)}"
    room = params[:room]

    if room.blank?
      render json: { error: 'Room name is required' }, status: :unprocessable_entity
    else
      service = TwilioVideoService.new
      token = service.generate_token(identity: identity, room: room)
      render json: { token: token, identity: identity }
    end
  end
end
