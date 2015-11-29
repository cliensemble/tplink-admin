require 'yaml'
module TplinkCli
  class Configuration
    attr_accessor :url
    attr_accessor :password
    attr_accessor :hostname_length
    attr_accessor :hosts

    CONFIG_FILE = "#{ENV['HOME']}/.tplinkcli"

    def defaults
      self.hosts ||= []
      self.hostname_length ||= 16
      self.password ||= 'admin'
      self.url ||= '192.168.0.1'
    end

    def self.instance
      @instance ||= File.exists?(CONFIG_FILE) ? load_yml() : new.tap(&:defaults)
    end

    def self.load_yml
      YAML.load_file(CONFIG_FILE)
    end

    def self.save
      File.open(CONFIG_FILE, 'w+') { |f| f.write(instance.to_yaml) }
    end
  end
end
