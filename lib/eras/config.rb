require "eras/adapters/file_system"

module Eras
  class Config
    attr_accessor :adapter, :ignored_error_classes

    def initialize
      @adapter = Eras::Adapters::FileSystem.new
      @ignored_error_classes = []
    end
  end
end
