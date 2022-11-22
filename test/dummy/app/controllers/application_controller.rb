class ApplicationController < ActionController::Base
  def raise_error
    Rails.error.record do
      raise "This is an error"
    end
  end
end
