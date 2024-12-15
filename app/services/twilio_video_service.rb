require 'twilio-ruby'

class TwilioVideoService
  def initialize
    @account_sid = ENV['TWILIO_ACCOUNT_SID']
    @api_key_sid = ENV['TWILIO_API_KEY_SID']
    @api_key_secret = ENV['TWILIO_API_KEY_SECRET']
  end

  def generate_token(identity:, room:)
    token = Twilio::JWT::AccessToken.new(
      @account_sid,
      @api_key_sid,
      @api_key_secret,
      identity: identity
    )

    video_grant = Twilio::JWT::AccessToken::VideoGrant.new
    video_grant.room = room
    token.add_grant(video_grant)

    token.to_jwt
  end
end
