# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "itamae-plugin-resource-pip"
  spec.version = "1.1.1"
  spec.authors = ["MATSUMOTO, Katsuyoshi"]
  spec.email = ["github@katsyoshi.org"]

  spec.summary = "Pip resource plugin for Itamae"
  spec.description = "Adds a pip resource to Itamae recipes for installing, upgrading, and uninstalling Python packages."
  spec.license = "MIT"
  spec.homepage = "https://github.com/katsyoshi/itamae-plugin-resource-pip"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "#{spec.homepage}/tree/master"
  spec.metadata["changelog_uri"] = "#{spec.homepage}/releases"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore .rspec spec/ .github/])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "itamae", ">= 1.2"
end
