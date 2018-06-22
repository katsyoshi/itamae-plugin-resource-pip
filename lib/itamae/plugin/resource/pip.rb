require 'itamae/resource/base'

module Itamae
  module Plugin
    module Resource
      class Pip < Itamae::Resource::Base
        define_attribute :action, default: :install
        define_attribute :pip_binary, type: [String, Array], default: ['pip', '--disable-pip-version-check']
        define_attribute :package_name, type: String, default_name: true
        define_attribute :options, type: [String, Array], default: :auto
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
          installed = installed_pips.find {|pip| pip[:name] == attributes.package_name }
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

        def action_upgrade(action_options)
          return if current.installed && attributes.version && attributes.version == current.version
          install!
          updated!
        end

        def action_uninstall(action_options)
          install!
          updated!
        end

        private

        def installed_pips
          pips = []
          run_command([*Array(attributes.pip_binary), 'freeze']).stdout.each_line do |line|
            name, version = line.split(/==/)
            pips << {name: name, version: version.chomp}
          end
          pips
        rescue Backend::CommandExecutionError
          []
        end

        def build_pip_install_command
          cmd = [*Array(attributes.pip_binary), 'install']
          cmd << attributes.options if attributes.options

          if attributes.version
            cmd << "#{attributes.package_name}==#{attributes.version}"
          else
            cmd << attributes.package_name
          end

          case @current_action
          when :upgrade
            cmd << '--upgrade'
          when :uninstall
            cmd.find {|w| w =~ /\Ainstall\z/ }.sub!(/\A/, 'un')
            cmd << '-y'
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
