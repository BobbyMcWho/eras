module Eras
  module Adapters
    class FileSystem
      def initialize(path = nil, &blk)
        @path = Rails.root.join("tmp", "eras.json")
      end

      def write_error(data)
        # TODO: Large numbers of errors will cause this to grow unbounded, could have memory issues.
        # Should we use file rotation, sqlite (separate adapter), or something else?
        File.open(@path, "w") do |f|
          errors = f.read.empty? ? [] : JSON.parse(f.read)
          errors << data
          f.write(data.to_json)
        end
      end

      def read_errors
        File.open(@path, "r") do |f|
          JSON.parse(f.read)
        end
      end
    end
  end
end
