require 'eras/error_reporter'

module Eras
  class Engine < ::Rails::Engine
    isolate_namespace Eras

    initializer "eras.assets" do |app|
      app.config.assets.precompile += %w[eras_manifest]
    end

    initializer "eras.error_subscriber" do |app|
      app.executor.error_reporter.subscribe(Eras::ErrorReporter.new)
    end
  end
end
