module ActiveadminSettingsCached
  class SettingsController < ApplicationController
    def update
      settings = ActiveadminSettingsCached.settings_klass

      #TODO: this method call save every param
      # save only changed values
      settings_params.each_pair do |name, value|
        if settings.defaults[name].is_a?(Hash)
          unless settings[name][:value] == value
            settings[name] = { as: settings.defaults[name][:as], value: value }
          end
        else
          settings[name] = value unless settings[name] == value
        end
      end

      redirect_to :back
    end

    private

    def settings_params
      settings_keys = ActiveadminSettingsCached.settings_klass.defaults.keys

      params.require(:settings).permit(settings_keys)
    end
  end
end
