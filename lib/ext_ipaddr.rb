require "ext_ipaddr/version"

require 'ipaddr'

IPAddr.class_eval do

  alias_method :_initialize, :initialize
  def initialize(addr='::', family=Socket::AF_UNSPEC)
    _initialize(addr, family)

    # DIRTY HACK
    # IPAddr by default cannot handle host address with prefix
    # e.g. 192.168.0.1/24
    # when passing above to the original constructor,
    # IPAddr returns 192.168.0.0/24
    # but using "|" operator somehow makes it possible, LOL
    # here we overwrite @addr again with the correct host address
    if addr.kind_of?(String)
      address, prefixlen = addr.split('/')
      if prefixlen
        @addr |= IPAddr.new(address, family).to_i
        # this means "192.168.0.0/24" | "192.168.0.1/32"
        # then we get "192.168.0.1/24"
      end
    end
  end

  def mask_address
    IPAddr.new(@mask_addr, @family)
  end

  def prefix_length
    begin_addr = (@addr & @mask_addr)

    case @family
    when Socket::AF_INET
      end_addr = (@addr | (self::class::IN4MASK ^ @mask_addr))
      return 32 - Math.log(end_addr - begin_addr + 1, 2).to_i
    when Socket::AF_INET6
      end_addr = (@addr | (self::class::IN6MASK ^ @mask_addr))
      return 128 - Math.log(end_addr - begin_addr + 1, 2).to_i
    else
      raise AddressFamilyError, "unsupported address family"
    end
  end

  def to_cidr_s
    return to_s + "/#{prefix_length}"
  end

  def ==(other)
    return false unless other.class == IPAddr
    self && other && @addr == other.to_i && @mask_addr == other.mask_addr
  end

protected

  def mask_addr
    return @mask_addr
  end

end
