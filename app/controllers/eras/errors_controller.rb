module Eras
  class ErrorsController < ApplicationController
    def index
      @errors = Eras::Adapters::FileSystem.new.read_errors
    end

    def show
      @error = Eras::Adapters::FileSystem.new.read_error(params[:id])
    end
  end
end
