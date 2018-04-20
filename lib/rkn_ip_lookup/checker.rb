module RknIpLookup
  module Checker
    class << self
      def check(ip)
        db.ips.include?(ip) ||
          db.cidrs.include?(ip) || false
      end

      private

      def db
        @db ||= Database.load
      end
    end
  end
end
