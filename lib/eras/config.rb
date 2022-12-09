require "eras/adapters/file_system"

module Eras
  class Config
    attr_accessor :adapter, :ignored_error_classes, :reporting_envs

    def initialize
      @adapter = Eras::Adapters::FileSystem.new
      @ignored_error_classes = []
      @reporting_envs = %w[development]
    end
  end
end
