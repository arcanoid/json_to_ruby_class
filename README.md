# JsonToRubyClass

[![Build Status](https://travis-ci.org/arcanoid/json_to_ruby_class.svg?branch=master)](https://travis-ci.org/arcanoid/json_to_ruby_class)
[![Gem Version](https://badge.fury.io/rb/json_to_ruby_class.svg)](https://badge.fury.io/rb/json_to_ruby_class)

JsonToRubyClass is a gem that converts a JSON to a list of Ruby classes and outputs it into a string.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'json_to_ruby_class'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install json_to_ruby_class

## Usage

```ruby
json = <<-JSON
{
  "students": [
    {
      "firstName": "John",
      "lastName": "Doe",
      "age": 15
    },
    {
      "firstName": "Anna",
      "lastName": "Smith",
      "age": 16
    }
  ]
}
JSON

puts JsonToRubyClass.produce_models(json)
```

This produces the following:

```ruby
Class Student
   attr_accessor :first_name,
                 :last_name,
                 :age
end

Class Example
   attr_accessor :students
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/json_to_ruby_class. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

