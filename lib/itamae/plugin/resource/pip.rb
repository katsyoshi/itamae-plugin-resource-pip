require 'itamae/resource/base'

module Itamae
  module Plugin
    module Resource
      class Pip < Itamae::Resource::Base
        define_attribute :action, default: :install
        define_attribute :pip_binary, type: [String, Array], default: 'pip'
        define_attribute :package_name, type: String, default_name: true
        define_attribute :version, type: String, default: false

        def pre_action
          case @current_action
          when :install
            attributes.installed = true
          when :uninstall
            attributes.installed = false
          end
        end
      end
    end
  end
end
