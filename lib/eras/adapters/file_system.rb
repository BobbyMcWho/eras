module Eras
  module Adapters
    class FileSystem
      def initialize(path = nil)
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
        File.open(@path, "r") do |f|
          JSON.parse(f.read)
        end
      end

      def read_error(id)
        read_errors.find { |e| e['id'] == id }
      end
    end
  end
end
