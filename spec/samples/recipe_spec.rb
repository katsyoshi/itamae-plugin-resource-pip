require "spec_helper"

describe "samples/recipe.rb" do
  let(:command_result) { double("command_result", stdout: "", exit_status: 0) }
  let(:backend) { double("backend", run_command: command_result) }
  let(:runner) { Itamae::Runner.new(backend, {}) }
  let(:recipe_path) { File.expand_path("../../samples/recipe.rb", __dir__) }

  before do
    runner.load_recipes([recipe_path])
  end

  it "defines pip[tornado] for a user-local install" do
    expect(runner.children.resources.size).to eq 1

    resource = runner.children.resources.first

    expect(resource).to be_a(Itamae::Plugin::Resource::Pip)
    expect(resource.resource_name).to eq "tornado"
    expect(resource.attributes.package_name).to eq "tornado"
    expect(resource.attributes.pip_binary).to eq "pip3"
    expect(resource.attributes.version).to eq "4.1"
    expect(resource.attributes.options).to eq "--user"
  end
end
