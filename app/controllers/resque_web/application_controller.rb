module ResqueWeb
  class ApplicationController < ActionController::Base
    protect_from_forgery
    before_filter :set_subtabs

    if ENV['DFC_USER']
      http_basic_authenticate_with name: ENV['DFC_USER'], password: ENV['DFC_PASSWORD']
    end

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
