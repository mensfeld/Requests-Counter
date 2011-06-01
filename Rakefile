require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('requests_counter', '0.1.5') do |p|
  p.description    = "Requests Counter allows you to count attemps to get resource. You can then decide if attemp should be stopped (banned)."
  p.url            = "https://github.com/mensfeld/Requests-Counter"
  p.author         = "Maciej Mensfeld"
  p.email          = "maciej@mensfeld.pl"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = ["rspec >=2.0.0"]
  p.dependencies = ["activerecord"]
end

