# config/initializers/config.rb
require 'ostruct'

def load_config_yaml(config_file)
  YAML.load(File.read(Rails.root.join('config', config_file)))[Rails.env]
end

AppConfig = OpenStruct.new()


AppConfig.paperclip = load_config_yaml('paperclip.yml')