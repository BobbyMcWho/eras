module Eras
  class ErrorReporter
    def initialize(adapter: Eras::Adapters::FileSystem.new(::Rails.env))
      @adapter = adapter
    end

    def report(error, handled:, severity:, context:, source: nil)
      context = context.merge(rails_env: ::Rails.env).transform_values(&:to_s)

      data = {
        error: {
          class: error.class.name,
          message: error.message,
          backtrace: error.backtrace&.join("\n")
        },
        handled: handled,
        severity: severity,
        context: context, # ActionController.to_s causes stack overflow
        source: source
      }
      @adapter.write_error(data)
    end
  end
end
