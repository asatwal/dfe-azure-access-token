# -*- encoding: utf-8 -*-
# stub: httpparty 0.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "httpparty".freeze
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jarmo Pertman".freeze]
  s.bindir = "exe".freeze
  s.date = "2022-08-16"
  s.email = ["jarmo@jarmopertman.com".freeze]
  s.homepage = "https://github.com/jarmo/httpparty".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.4.19".freeze
  s.summary = "Alias gem for httparty".freeze

  s.installed_by_version = "3.4.19" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<httparty>.freeze, ["> 0"])
  s.add_development_dependency(%q<bundler>.freeze, ["~> 1.17"])
  s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
end
