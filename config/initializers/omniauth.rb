APP_CODE = '4a3b4b7eefcdd701'
APP_SECRET = 'a5e58cc0318eb3a3c48b951a3b086811'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :proto, APP_CODE, APP_SECRET
end
