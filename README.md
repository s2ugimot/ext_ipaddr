# ExtIPAddr

Monkey patch for ruby built-in IPAddr class to make it support CIDR notation.

```ruby
IPAddr.new('192.0.2.1/24')
# => #<IPAddr: IPv4:192.0.2.1/255.255.255.0>

IPAddr.new('2001:db8::1/64')
# => #<IPAddr: IPv6:2001:0db8:0000:0000:0000:0000:0000:0001/ffff:ffff:ffff:ffff:0000:0000:0000:0000>
```


## Why we need this?

This gem is intended to use with ActiveRecord and PostgreSQL.
With this gem installed, you can store IP address with prefix length information (e.g. "192.0.2.1/24", "2001:db8::1/64") into inet type columns.

ActiveRecord itself supports PostgreSQL inet type since Rails 4, but it maps to ruby built-in IPAddr class which does not support CIDR notation by default.
This gem enables it by tweaking IPAddr class.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ext_ipaddr'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ext_ipaddr


## Usage

```ruby
require 'ext_ipaddr'

IPAddr.new('192.0.2.1/24')
# => #<IPAddr: IPv4:192.0.2.1/255.255.255.0>

IPAddr.new('2001:db8::1/64')
# => #<IPAddr: IPv6:2001:0db8:0000:0000:0000:0000:0000:0001/ffff:ffff:ffff:ffff:0000:0000:0000:0000>

IPAddr.new('2001:db8::1/64').to_cidr_s
# => "2001:db8::1/64"

IPAddr.new('2001:db8::1/64').prefix_length
# => 64

IPAddr.new('192.0.2.1/24') == IPAddr.new('192.0.2.1/24')
# => true

IPAddr.new('192.0.2.1/24') == IPAddr.new('192.0.2.1/32')
# => false
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/s2ugimot/ext_ipaddr
