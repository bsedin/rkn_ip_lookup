# Rkn IP/Hostname Lookup

Check IP or hostname presence in RKN blocked resources list.
Currently only antizapret.info supported (https://api.antizapret.info/group.php?data=ip).
Feel free to contribute

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rkn_ip_lookup'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rkn_ip_lookup

## Usage

    RknIpLookup::Checker.check('127.0.0.1') #=> false
    RknIpLookup::Checker.check('google.com') #=> false
    RknIpLookup::Checker.check('yandex.ru') #=> false
    RknIpLookup::Checker.check('s3.eu-central-1.amazonaws.com') #=> #<IPAddr: IPv4:52.192.0.0/255.224.0.0>. This means IP was blocked by CIDR `52.192.0.0/11`

### Database

I use singleton `RknIpLookup::Database` to store fetched IPs. It caches by default with ruby marshal. To reset cache do

    RknIpLookup::Database.reload

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kressh/rkn_ip_lookup .

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
