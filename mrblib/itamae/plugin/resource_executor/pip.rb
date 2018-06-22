module ::MItamae
  module Plugin
    module ResourceExecutor
      class Pip < ::MItamae::ResourceExecutor::Base
        def apply
          if desired.installed
            if current.installed
              if desired.version && current.version != desired.version
                install!
                updated!
              end
            else
              install!
              updated!
            end
          else
            uninstall! if current.installed
          end
        end

        private

        def set_current_attributes(current, action)
          installed = installed_pips.find {|pip| pip[:name] == attributes.package_name }
          current.installed = !!installed

          if current.installed
            version = installed[:version]
            current.version = version if version != attributes.version
          end
        end

        def installed_pips
          pips = []
          run_command([*Array(attributes.pip_binary), 'freeze']).stdout.each_line do |line|
            name, version = line.chomp.split(/==/)
            pips << {name: name, version: version}
          end
          pips
        rescue Backend::CommandExecutionError
          []
        end

        def set_desired_attributes(desired, action)
          case action
          when :install, :upgrade
            desired.installed = true
          when :uninstall
            desired.installed = false
          end
        end

        def build_pip_install_command
        end

        def install!
          cmd = [*Array(attributes.pip_binary), 'install']
          cmd << attributes.options if attributes.options

          if attributes.version
            cmd << "#{attributes.package_name}==#{attributes.version}"
          else
            cmd << attributes.package_name
          end

          run_command(cmd)
        end

        def uninstall!
          cmd = [*Array(attributes.pip_binary), 'uninstall']
          cmd << attributes.options if attributes.options

          if attributes.version
            cmd << "#{attributes.package_name}==#{attributes.version}"
          else
            cmd << attributes.package_name
          end
          cmd << '-y'

          run_command(cmd)
        end
      end
    end
  end
end
