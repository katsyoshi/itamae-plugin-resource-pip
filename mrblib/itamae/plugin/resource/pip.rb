module ::MItamae
  module Plugin
    module Resource
      class Pip < ::MItamae::Resource::Base
        define_attribute :action, default: :install
        define_attribute :pip_binary, type: [String, Array], default: 'pip'
        define_attribute :package_name, type: String, default_name: true
        define_attribute :options, type: [String, Array], default: :auto
        define_attribute :version, type: String, default: false

        self.available_actions = [:install, :uninstall, :upgrade]
      end
    end
  end
end
