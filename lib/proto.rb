require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Proto < OmniAuth::Strategies::OAuth2
      CUSTOM_PROVIDER_URL = 'http://localhost:3000'

      option :client_options, {
        :site => CUSTOM_PROVIDER_URL,
        :authorize_url => "#{CUSTOM_PROVIDER_URL}/auth/proto/authorize",
        :access_token_url => "#{CUSTOM_PROVIDER_URL}/auth/proto/access_token"
      }

      uid { raw_info['id'] }

      info do
        {
          :email => raw_info['email']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get("/auth/proto/user.json?oauth_token=#{access_token.token}").parsed
      end
    end
  end
end
