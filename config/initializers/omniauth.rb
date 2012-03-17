APP_ID = '4a3b4b7eefcdd70b'
APP_SECRET = 'a5e58cc0318eb3a3c48b951a3b086813'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :proto, APP_ID, APP_SECRET
end
