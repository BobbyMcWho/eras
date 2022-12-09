module Eras
  class ErrorReporter
    def report(error, handled:, severity:, context:, source: nil)
      return if Eras.config.ignored_error_classes.include?(error.class.name)

      context = context.merge(rails_env: ::Rails.env).transform_values(&:to_s)

      data = {
        error: {
          class: error.class.name,
          message: error.message,
          backtrace: error.backtrace&.join("\n")
        },
        handled: handled,
        severity: severity,
        context: context,
        source: source
      }
      Eras.adapter.write_error(data)
    end
  end
end
