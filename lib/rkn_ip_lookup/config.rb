require 'dry-configurable'

module RknIpLookup
  module Config
    def self.included(base)
      base.instance_eval do
        extend Dry::Configurable

        setting :database do
          setting :provider,        :antizapret
          setting :cache,           true
          setting :cache_file_path, 'tmp/cache/database.dump'
        end

        setting :logger, Logger.new(STDOUT), reader: true
      end
    end
  end
end
