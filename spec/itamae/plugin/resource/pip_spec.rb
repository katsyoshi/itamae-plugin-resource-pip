require "spec_helper"

describe Itamae::Plugin::Resource::Pip do
  describe "installed pips" do
    let(:backend) { double("backend", run_command: output) }
    let(:runner) { double("runner", backend: backend) }
    let(:recipe) { double("recipe", runner: runner) }
    let(:resource) { Itamae::Plugin::Resource::Pip.new(recipe, "test-service") }

    context "with name and version" do
      let(:output) { double("output", stdout: "Babel==2.10.3") }
      it { expect(resource.send(:installed_pips)).to eq [{ name: "Babel", version: "2.10.3" }] }
    end

    context "with name and file" do
      let(:output) { double("output", stdout: "importlib-metadata @ file:///tmp/guix-build-python-importlib-metadata-5.2.0.drv-0/importlib_metadata-5.2.0/dist/importlib_metadata-5.2.0-py3-none-any.whl") }
      it { expect(resource.send(:installed_pips)).to eq [{ name: "importlib-metadata" }] }
    end
  end
end
