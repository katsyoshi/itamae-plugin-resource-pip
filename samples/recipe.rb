require "itamae/plugin/resource/pip"

pip "tornado" do
  pip_binary "pip3"
  version "4.1"
  options "--prefix=/.pip"
end
