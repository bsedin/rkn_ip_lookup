require_relative 'types/cidrs'

module RknIpLookup
  class Database
    attr_accessor :data

    class << self
      def load
        @db ||= new.tap(&:load)
      end

      def method_missing(meth, *args)
        load.public_send(meth)
      end
    end

    def load
      self.data = RknIpLookup.config.database.cache && load_from_file || RknIpLookup::Provider::Antizapret.fetch.data
      dump_to_file if RknIpLookup.config.database.cache
    end

    def load_from_file(filename = nil)
      filename ||= RknIpLookup.config.database.cache_file_path
      return unless File.exist? filename
      Marshal.load(File.read(filename))
    end

    def dump_to_file(filename = nil)
      filename ||= RknIpLookup.config.database.cache_file_path
      File.open(filename, 'w') do |f|
        f.write Marshal.dump(data)
        f.close
      end
      data
    end

    def ips
      @ips ||= Set.new(entries.select { |x| x =~ /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/ })
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
