require 'spec_helper'

describe ExtIPAddr do
  it 'has a version number' do
    expect(ExtIPAddr::VERSION).not_to be nil
  end

  describe :ipv4 do
    it 'can set cidr address' do
      expect(IPAddr.new('192.0.2.1/0').to_cidr_s).to  eq('192.0.2.1/0')
      expect(IPAddr.new('192.0.2.1/23').to_cidr_s).to eq('192.0.2.1/23')
      expect(IPAddr.new('192.0.2.1/24').to_cidr_s).to eq('192.0.2.1/24')
      expect(IPAddr.new('192.0.2.1/25').to_cidr_s).to eq('192.0.2.1/25')
      expect(IPAddr.new('192.0.2.1/32').to_cidr_s).to eq('192.0.2.1/32')

      expect(IPAddr.new('192.0.2.1/0.0.0.0').to_cidr_s).to         eq('192.0.2.1/0')
      expect(IPAddr.new('192.0.2.1/255.255.254.0').to_cidr_s).to   eq('192.0.2.1/23')
      expect(IPAddr.new('192.0.2.1/255.255.255.0').to_cidr_s).to   eq('192.0.2.1/24')
      expect(IPAddr.new('192.0.2.1/255.255.255.128').to_cidr_s).to eq('192.0.2.1/25')
      expect(IPAddr.new('192.0.2.1/255.255.255.255').to_cidr_s).to eq('192.0.2.1/32')
    end

    it 'returns proper mask_address' do
      expect(IPAddr.new('192.0.2.1/0').mask_address).to  eq(IPAddr.new('0.0.0.0'))
      expect(IPAddr.new('192.0.2.1/24').mask_address).to eq(IPAddr.new('255.255.255.0'))
      expect(IPAddr.new('192.0.2.1/32').mask_address).to eq(IPAddr.new('255.255.255.255'))
    end

    it 'returns proper prefix' do
      expect(IPAddr.new('192.0.2.1/0').prefix).to  eq(0)
      expect(IPAddr.new('192.0.2.1/24').prefix).to eq(24)
      expect(IPAddr.new('192.0.2.1/32').prefix).to eq(32)
    end

    it 'overrides == properly' do
      expect(IPAddr.new('192.0.2.1/24')).to     eq(IPAddr.new('192.0.2.1/24'))
      expect(IPAddr.new('192.0.2.1/24')).to     eq(IPAddr.new('192.0.2.1/255.255.255.0'))

      expect(IPAddr.new('192.0.2.1/24')).not_to eq(IPAddr.new('192.0.2.1'))
      expect(IPAddr.new('192.0.2.1/24')).not_to eq(IPAddr.new('192.0.2.1/0'))
      expect(IPAddr.new('192.0.2.1/24')).not_to eq(IPAddr.new('192.0.2.1/32'))

      expect(IPAddr.new('192.0.2.1/24')).not_to eq(IPAddr.new('192.0.2.2/24'))
    end
  end

  describe :ipv6 do
    it 'can set cidr address' do
      expect(IPAddr.new('2001:db8::1/0').to_cidr_s).to   eq('2001:db8::1/0')
      expect(IPAddr.new('2001:db8::1/47').to_cidr_s).to  eq('2001:db8::1/47')
      expect(IPAddr.new('2001:db8::1/48').to_cidr_s).to  eq('2001:db8::1/48')
      expect(IPAddr.new('2001:db8::1/49').to_cidr_s).to  eq('2001:db8::1/49')
      expect(IPAddr.new('2001:db8::1/64').to_cidr_s).to  eq('2001:db8::1/64')
      expect(IPAddr.new('2001:db8::1/128').to_cidr_s).to eq('2001:db8::1/128')
    end

    it 'returns proper mask_address' do
      expect(IPAddr.new('2001:db8::1/0').mask_address).to   eq(IPAddr.new('::'))
      expect(IPAddr.new('2001:db8::1/48').mask_address).to  eq(IPAddr.new('ffff:ffff:ffff::'))
      expect(IPAddr.new('2001:db8::1/128').mask_address).to eq(IPAddr.new('ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff'))
    end

    it 'returns proper prefix' do
      expect(IPAddr.new('2001:db8::1/0').prefix).to   eq(0)
      expect(IPAddr.new('2001:db8::1/48').prefix).to  eq(48)
      expect(IPAddr.new('2001:db8::1/128').prefix).to eq(128)
    end

    it 'overrides == properly' do
      expect(IPAddr.new('2001:db8::1/48')).to     eq(IPAddr.new('2001:db8::1/48'))

      expect(IPAddr.new('2001:db8::1/48')).not_to eq(IPAddr.new('2001:db8::1'))
      expect(IPAddr.new('2001:db8::1/48')).not_to eq(IPAddr.new('2001:db8::1/0'))
      expect(IPAddr.new('2001:db8::1/48')).not_to eq(IPAddr.new('2001:db8::1/128'))

      expect(IPAddr.new('2001:db8::1/48')).not_to eq(IPAddr.new('2001:db8::2/48'))
    end
  end
end
