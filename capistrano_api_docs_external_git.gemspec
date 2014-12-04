# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "capistrano_api_docs_external_git"
  spec.version       = "1.0.1"
  spec.authors       = ["DevOps Team"]
  spec.email         = ["devops@ndrive.com"]
  spec.summary       = %q{Add tasks to capistrano to a Rails project to work with gem api_docs.}
  spec.description   = %q{Add tasks to capistrano to a Rails project to work with gem api_docs, and send files remotely to other git repository}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'git', "~> 1.2"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
