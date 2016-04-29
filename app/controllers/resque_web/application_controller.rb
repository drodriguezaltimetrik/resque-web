module ResqueWeb
  class ApplicationController < ActionController::Base
    protect_from_forgery
    before_filter :set_subtabs
    http_basic_authenticate_with name: 'us3r', password: 'developermarketingtotallyrocks!'

    helper :all

    def self.subtabs(*tab_names)
      return defined?(@subtabs) ? @subtabs : [] if tab_names.empty?
      @subtabs = tab_names
    end

    def set_subtabs(subtabs = self.class.subtabs)
      @subtabs = subtabs
    end
  end
end
