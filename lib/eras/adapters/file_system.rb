module Eras
  module Adapters
    class FileSystem
      include ActionView::Helpers::NumberHelper
      attr_reader :path

      def initialize(path = nil)
        if path.nil?
          dir = Rails.root.join("tmp", "eras")
          Dir.mkdir(dir) unless File.exists?(dir)
        end
        @path = Rails.root.join("tmp", "eras", "errors.json")
      end

      def write_error(data)
        # Database adapters may have an id, but filesystem adapters don't
        data['id'] = SecureRandom.uuid

        # TODO: Large numbers of errors will cause this to grow unbounded, could have memory issues.
        # Should we use file rotation, sqlite (separate adapter), or something else?
        existing_errors = begin
          JSON.parse(File.read(@path))
        rescue Errno::ENOENT, JSON::ParserError
          []
        end

        File.open(@path, "w") do |f|
          errors = existing_errors
          errors.unshift(data)
          f.write(errors.to_json)
        end
      end

      def read_errors
        return [] unless File.exist?(@path)

        File.open(@path, "r") do |f|
          JSON.parse(f.read)
        end
      end

      def read_error(id)
        read_errors.find { |e| e['id'] == id }
      end

      def destroy_file
        return unless File.exist?(@path)
        File.delete(@path)
      end

      def file_size
        size = File.exist?(@path) ? File.size(@path) : 0
        number_to_human_size(size)
      end
    end
  end
end
