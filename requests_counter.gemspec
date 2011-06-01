# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{requests_counter}
  s.version = "0.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Maciej Mensfeld"]
  s.date = %q{2011-06-01}
  s.description = %q{Requests Counter allows you to count attemps to get resource. You can then decide if attemp should be stopped (banned).}
  s.email = %q{maciej@mensfeld.pl}
  s.extra_rdoc_files = ["CHANGELOG.rdoc", "README.md", "lib/generators/my_requests_counter/install_generator.rb", "lib/generators/my_requests_counter/templates/create_requests_counters_migration.rb", "lib/generators/my_requests_counter/templates/requests_counter_init.rb", "lib/requests_counter.rb"]
  s.files = ["CHANGELOG.rdoc", "Gemfile", "MIT-LICENSE", "Manifest", "README.md", "Rakefile", "init.rb", "lib/generators/my_requests_counter/install_generator.rb", "lib/generators/my_requests_counter/templates/create_requests_counters_migration.rb", "lib/generators/my_requests_counter/templates/requests_counter_init.rb", "lib/requests_counter.rb", "spec/requests_counter_spec.rb", "spec/spec_helper.rb", "requests_counter.gemspec"]
  s.homepage = %q{https://github.com/mensfeld/Requests-Counter}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Requests_counter", "--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{requests_counter}
  s.rubygems_version = %q{1.5.2}
  s.summary = %q{Requests Counter allows you to count attemps to get resource. You can then decide if attemp should be stopped (banned).}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 2.0.0"])
    else
      s.add_dependency(%q<activerecord>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 2.0.0"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 2.0.0"])
  end
end
