require 'tplink-cli/app'
require 'tplink-cli/version'
require 'tplink-cli/configuration'

module TplinkCli
  def self.config
    TplinkCli::Configuration.instance
  end


end
