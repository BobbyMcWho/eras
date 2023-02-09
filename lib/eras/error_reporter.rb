module Eras
  class ErrorReporter
    def report(error, handled:, severity:, context:, source: nil)
      return if Eras.config.ignored_error_classes.include?(error.class.name)
      return unless Eras.config.reporting_envs.include?(::Rails.env)

      context = context.merge(rails_env: ::Rails.env).transform_values(&:to_s)
      kaller = caller

      data = {
        handled: handled,
        severity: severity,
        context: context,
        source: source
      }.tap do |d|
        # This doesn't feel very elegant, but it'll do for now
        d[:error] = if error.is_a?(Exception)
                      {
                        title: error.class.name,
                        message: error.message,
                        backtrace: error.backtrace&.join("\n")
                      }
                    else
                      {
                        title: "[message]",
                        message: error,
                        backtrace: cleaner.clean(kaller).join("\n")
                      }
                    end
      end
      Eras.adapter.write_error(data)
    end

    def cleaner
      @cleaner ||= begin
        cleaner = ActiveSupport::BacktraceCleaner.new
        cleaner.add_silencer { |line| line =~ %r{eras/error_reporter.rb} }
        cleaner
      end
    end
  end
end
