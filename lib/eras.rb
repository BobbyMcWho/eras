require "eras/version"
require "eras/engine"
require "eras/config"

module Eras
  def self.config
    @config ||= Eras::Config.new
  end

  def self.configure
    yield config
  end

  def self.adapter
    config.adapter
  end
end
