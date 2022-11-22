require_relative "lib/eras/version"

Gem::Specification.new do |spec|
  spec.name        = "eras"
  spec.version     = Eras::VERSION
  spec.authors     = ["Bobby McDonald"]
  spec.email       = ["bobbymcwho@gmail.com"]
  spec.homepage    = "https://github.com/bobbymcwho/eras"
  spec.summary     = "Local error visibility for Rails' ActiveSupport::ErrorReporter"
  spec.description = "Local error visibility for Rails' ActiveSupport::ErrorReporter"
  spec.license     = "MIT"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.4"
end
