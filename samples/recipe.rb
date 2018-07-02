require "itamae/plugin/resource/pip"

pip "tornado" do
  pip_binary "/.pyenv/shims/pip"
  version "4.1"
  options "--prefix=/.pip"
end
