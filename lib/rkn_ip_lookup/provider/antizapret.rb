require 'faraday'

module RknIpLookup
  class Provider
    class Antizapret < Provider
      DATABASE_URL = 'https://api.antizapret.info/group.php?data=ip'.freeze

      attr_accessor :response, :data

      def fetch
        self.response = Faraday.get DATABASE_URL
        self.data     = parse_response
      end

      private

      def parse_response
        response.body.split("\n").flat_map do |line|
          line.split(',')
        end
      end
    end
  end
end
