module Eras
  class ErrorsController < ApplicationController
    before_action :set_file_attrs
    before_action :set_environment, only: [:index, :show]

    def index
      @errors = Eras.adapter.read_errors.filter { |e| e['context']['rails_env'] == @environment }
    end

    def show
      @error = Eras.adapter.read_error(params[:id])
    end

    def destroy
      # TODO: rename to be adapter agnostic
      Eras.adapter.destroy_file
    end

    def set_environment
      @environment = params[:environment] || 'development'
    end

    def set_file_attrs
      @file_path = Eras.adapter.path
      @file_size = Eras.adapter.file_size
    end
  end
end
