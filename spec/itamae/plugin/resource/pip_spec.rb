require "spec_helper"

describe Itamae::Plugin::Resource::Pip do
  describe "installed pips" do
    it "name and version" do
      output = double("output", stdout: "Babel==2.10.3")
      backend = double("backend", run_command: output)
      runner = double("runner", backend: backend)
      recipe = double("recipe", runner: runner)
      resource = Itamae::Plugin::Resource::Pip.new(recipe, "test-service")
      expect(resource.send(:installed_pips)).to eq [{ name: "Babel", version: "2.10.3" }]
    end
  end
end
