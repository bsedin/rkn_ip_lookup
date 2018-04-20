
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rkn_ip_lookup/version'

Gem::Specification.new do |spec|
  spec.name          = 'rkn_ip_lookup'
  spec.version       = RknIpLookup::VERSION
  spec.authors       = ['Sergey Besedin']
  spec.email         = ['kr3ssh@gmail.com']

  spec.summary       = %q{Check server IP in RKN block lists}
  spec.description   = %q{Fuck RKN}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'dry-configurable'
  spec.add_dependency 'faraday'
  spec.add_dependency 'pry'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
