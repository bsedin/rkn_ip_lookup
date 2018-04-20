module RknIpLookup
  class Provider
    def self.fetch
      new.tap(&:fetch)
    end

    def fetch
      Antizapret.fetch
    end
  end
end

require 'rkn_ip_lookup/provider/antizapret'
