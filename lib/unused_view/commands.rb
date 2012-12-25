# -*- coding: utf-8 -*-

require 'console_command'
command_glob = File.expand_path('../commands/*.rb', __FILE__)
Dir[command_glob].each do |command|
  require command
end
