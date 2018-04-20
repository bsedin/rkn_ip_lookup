module RknIpLookup
  module Checker
    class << self
      def check(host_or_ip)
        if host_or_ip.match?(/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/)
          check_ip(host_or_ip)
        else
          check_host(host_or_ip)
        end
      end

      def check_ip(ip)
        db.ips.include?(ip) || db.cidrs.include?(ip) || false
      end

      def check_host(host)
        ip = IPSocket.getaddress(host)
        check_ip(ip)
      rescue SocketError
        false
      end

      private

      def db
        Database.load
      end
    end
  end
end
