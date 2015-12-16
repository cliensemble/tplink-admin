require 'tplink-admin/app'
require 'tplink-admin/version'
require 'tplink-admin/configuration'

module TplinkAdmin
  def self.config
    TplinkAdmin::Configuration.instance
  end
end
