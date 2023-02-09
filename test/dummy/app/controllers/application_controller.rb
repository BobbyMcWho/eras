class ApplicationController < ActionController::Base
  def raise_error
    Rails.error.record do
      raise "This is an error"
    end
  end

  def report_message
    Rails.error.report("This is a message", handled: true)
    render plain: "Message reported"
  end
end
