require 'rapidjob'
require 'rails'
module Rapid
  class Railtie < Rails::Railtie
    require 'rapid/worker'
  end
end
