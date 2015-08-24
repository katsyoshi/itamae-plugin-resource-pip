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

        def set_current_attributes
          installed = installed_pips.find {|g| g[:name] == attributes.package_name }
          current.installed = !!installed

          if current.installed
            version = installed[:version]
            current.version = version if version != attributes.version
          end
        end

        def action_install(action_options)
          if current.installed
            if attributes.version && current.version != attributes.version
              install!
              updated!
            end
          else
            install!
            updated!
          end
        end

        private

        def installed_pips
          pips = []
          run_command([*Array(attributes.pip_binary), 'freeze']).stdout.each_line do |line|
            name, version = line.split(/==/)
            pips << {name: name, version: version}
          end
          pips
        rescue Backend::CommandExecutionError
          []
        end

        def build_pip_install_command
          cmd = [*Array(attributes.pip_binary), 'install']
          if attributes.version
            cmd << "#{attributes.package_name}==#{attributes.version}"
          else
            cmd << attributes.package_name
          end
          cmd
        end

        def install!
          run_command(build_pip_install_command)
        end
      end
    end
  end
end
