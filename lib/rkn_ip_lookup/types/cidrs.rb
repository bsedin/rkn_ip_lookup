module RknIpLookup
  module Types
    class Cidrs < Array
      def initialize(array)
        super(array.map { |addr| IPAddr.new(addr) })
      end

      def include?(el)
        self.find { |cidr| cidr.include?(el) }
      end
    end
  end
end
