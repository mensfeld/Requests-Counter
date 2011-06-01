# Requests Counter

## Install

    gem install requests_counter

and in your Gemfile:
    
    gem 'requests_counter'

## About

Requests Counter allows you to count attemps to get resource. You can then decide if attemp should be stopped (banned).

When you want to limit attemps to something (for example to login form), you can count attemps and decide whether to show or not to show login form.

Works with Ruby 1.8.7, 1.8.7 EE, 1.9.2

## Requirements

    ActiveRecord

## Simple example

    # Example with IP
    10.times { RequestsCounter.with_token('127.0.0.1').permitted? } ==> true
    RequestsCounter.with_token('127.0.0.1').permit? ==> false

    # You can also use
    req = RequestsCounter.find_by_token('127.0.0.1')
    reg.permit? ==> true

Wait 1 hour and then

    RequestsCounter.with_token('127.0.0.1').permit? ==> true
    
Class methods:

* with_token(token, resource = nil, params ={}) - will give you back resource counter (if not found - will create one)
* permitted?(token, resource = nil, params ={}) - will tell you is token permitted to resource - without counting attempts
* permit?(token, resource = nil, params ={}) - same as above, but will count attempts
* remaining(token, resource = nil, params ={}) - how much attempts left

Instance methods:

* permitted? - will tell you is token permitted to resource - without counting attempts
* permit? - same as above, but will count attempts
* reset! - will reset counter
* remaining - how much attempts left

For more examples view rspec.

## Setup

    rails generate my_requests_counter:install

## Tests

    rspec requests_counter_spec.rb

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with Rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 Maciej Mensfeld. See LICENSE for details.
