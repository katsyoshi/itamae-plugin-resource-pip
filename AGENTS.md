# Repository Guidelines

## Project Structure & Module Organization
`lib/itamae/plugin/resource/pip.rb` contains the main CRuby Itamae resource. `mrblib/itamae/plugin/resource/pip.rb` and `mrblib/itamae/plugin/resource_executor/pip.rb` provide the parallel MItamae implementation, so behavior changes usually need matching updates in both trees. RSpec coverage lives in `spec/`, with the current resource spec at `spec/itamae/plugin/resource/pip_spec.rb`. Use `samples/recipe.rb` as the minimal usage example. `Dockerfile` and `manifest.scm` are optional reproducible environments for local testing.

## Build, Test, and Development Commands
- `bundle install` installs gem dependencies from `itamae-plugin-resource-pip.gemspec`.
- `bundle exec rake` runs the default `test` task and executes the full RSpec suite.
- `bundle exec rspec spec/itamae/plugin/resource/pip_spec.rb` runs the focused resource spec while iterating on parsing or command-building logic.
- `bundle exec itamae local samples/recipe.rb` smoke-tests the plugin against the sample recipe.
- `docker build .` exercises the Dockerfile-based integration path with `python3-pip` installed.

## Coding Style & Naming Conventions
Follow the existing Ruby style: 2-space indentation, compact module nesting, and small private helper methods. Match the surrounding file’s string style; production code currently favors single quotes unless interpolation is needed. Keep class and module names aligned with their paths, for example `Itamae::Plugin::Resource::Pip` in `lib/itamae/plugin/resource/pip.rb`. When adding attributes or actions, keep names descriptive and consistent with Itamae’s DSL (`pip_binary`, `package_name`, `action_install`).

## Testing Guidelines
RSpec is the only configured test framework. Add or update specs for every behavior change, especially parsing of `pip freeze` output and install/uninstall command construction. Name new spec files with the `_spec.rb` suffix and place them under the mirrored namespace in `spec/`. There is no enforced coverage threshold, so use targeted examples to cover regressions before submitting a change.

## Commit & Pull Request Guidelines
Recent history uses short, imperative subjects such as `Add failing test` and `fix default value of options attribute`. Prefer one focused change per commit and keep the subject line concise. Pull requests should explain the user-visible behavior change, mention any Itamae/MItamae compatibility impact, and list the commands you ran to validate the update.
