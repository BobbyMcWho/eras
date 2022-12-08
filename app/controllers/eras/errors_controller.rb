module Eras
  class ErrorsController < ApplicationController
    include ActionView::Helpers::NumberHelper

    before_action :set_file_attrs

    def index
      @environment = params[:environment] || 'development'
      # TODO: We need to actually respect the adapter that's used,
      # and not just assume it's the filesystem adapter.
      @errors = Eras::Adapters::FileSystem.new.read_errors.filter { |e| e['context']['rails_env'] == @environment }
    end

    def show
      @error = Eras::Adapters::FileSystem.new.read_error(params[:id])
    end

    def set_file_attrs
      # TODO: We need to store the active adapter as a singleton somewhere
      # so we can use it places instead of creating new ones.
      @file_path = Eras::Adapters::FileSystem.new.path
      @file_size = number_to_human_size(File.size(@file_path))
    end
  end
end
