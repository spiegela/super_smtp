# SuperSmtp

Support Specific Source IP in Net::SMTP

## About

 This is kind of a dumb monkey-patch of Net::SMTP, but it's an easy way to
 support an extra option in Net::SMTP.

## Installation

Add this line to your application's Gemfile:

    gem 'super_smtp'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install super_smtp

## Usage

To use, just add a third parameter when you initialize your Net::SMTP connection:

```ruby
# If my local interface is 192.168.0.2
smtp = Net::SMTP.new('remote-mx.domain.com', 25, '192.168.0.2')
# boom.  That's it.  Simplest gem evar.
```

## TODO

  I dunno... Maybe submit a pull request to Ruby to support this?

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
