TextMessenger::Application.config.x.twilio.auth = YAML.load_file("#{Rails.root}/config/twilio_auth.yml")[Rails.env]
