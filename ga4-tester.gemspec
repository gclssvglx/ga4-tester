require_relative 'lib/ga4/tester/version'

Gem::Specification.new do |spec|
  spec.name          = "ga4-tester"
  spec.version       = Ga4::Tester::VERSION
  spec.authors       = ["Graham Lewis"]
  spec.email         = ["44037625+gclssvglx@users.noreply.github.com"]

  spec.summary       = %q{A Google Analytics 4 Tester}
  spec.description   = %q{A Google Analytics 4 Tester}
  spec.homepage      = "https://github.com/gclssvglx/ga4-tester"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = ""

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/gclssvglx/ga4-tester"
  spec.metadata["changelog_uri"] = "https://github.com/gclssvglx/ga4-tester/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "selenium-webdriver"
  spec.add_dependency "capybara"
end
