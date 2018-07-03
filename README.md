# Itamae::Plugin::Resource::Pip [![Build Status](https://travis-ci.org/katsyoshi/itamae-plugin-resource-pip.svg?branch=master)](https://travis-ci.org/katsyoshi/itamae-plugin-resource-pip)

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/itamae/plugin/resource/pip`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'itamae-plugin-resource-pip'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install itamae-plugin-resource-pip

## Usage

write recipe:
```ruby
require 'itamae/plugin/resource/pip'
pip "tornado" do
  pip_binary "/home/user/.pyenv/shims/pip"
  version "4.1"
  options '--user'
end
```

run script:
```console
$ itamae local recipe.rb
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/katyoshi/itamae-plugin-resource-pip. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


### Contributors

[@n0ts](https://github.com/n0ts): [#1](https://github.com/katsyoshi/itamae-plugin-resource-pip/pull/1) delete included version newline code

[@mystelynx](https://github.com/mystelynx): [#2](https://github.com/katsyoshi/itamae-plugin-resource-pip/pull/2) support mitamae

[@ta1kt0me](https://github.com/ta1kt0me): [#3](https://github.com/katsyoshi/itamae-plugin-resource-pip/pull/3) :bug: fixed mitamae

[@citystar](https://github.com/citystar): [#4](https://github.com/katsyoshi/itamae-plugin-resource-pip/pull/4) ignore pip version

[@moritzheiber](https://github.com/moritzheiber): [#5](https://github.com/katsyoshi/itamae-plugin-resource-pip/pull/6) support pip option
