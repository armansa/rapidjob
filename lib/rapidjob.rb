require "bunny"

require "rapid/version"
require "rapid/job"
require "rapid/task"
require 'rapid/railtie' if defined?(Rails)

module Rapid
  class << self
    def get_channel
      conn = Bunny.new
      conn.start
      conn.create_channel
    end
  end
end
