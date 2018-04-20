require_relative 'types/cidrs'

module RknIpLookup
  class Database
    attr_accessor :data
    attr_accessor :updated_at

    class << self
      def load(skip_cache: false)
        return @db if @db && !skip_cache

        @db = !skip_cache && RknIpLookup.config.database.cache && load_from_file || new.load
        @db
      end

      def method_missing(meth, *args)
        load.public_send(meth)
      end

      def reload
        load(skip_cache: true)
      end

      def load_from_file(filename = nil)
        filename ||= RknIpLookup.config.database.cache_file_path
        return unless File.exist? filename
        @db = Marshal.load(File.read(filename))
      end
    end

    def load
      provider_data = RknIpLookup::Provider::Antizapret.fetch
      self.data = provider_data.data
      self.updated_at = Time.now

      dump_to_file if RknIpLookup.config.database.cache
      self
    end

    def dump_to_file(filename = nil)
      filename ||= RknIpLookup.config.database.cache_file_path
      File.open(filename, 'w') do |f|
        f.write Marshal.dump(self)
        f.close
      end
      data
    end

    def ips
      @ips ||= Set.new(entries.select { |x| x.match?(/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/) })
    end

    def cidrs
      @cidrs ||= Types::Cidrs.new(entries.select { |x| x =~ %r{\.0/\d+} })
    end

    def hosts
      @hosts ||= []
    end

    def entries
      @entries ||= Set.new(data)
    end
  end
end
