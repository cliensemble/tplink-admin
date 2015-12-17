require 'thor'
require 'tplink-admin/helpers/iniparse'
require 'tplink-admin/helpers/client'
require 'base64'

module TplinkAdmin
  class App < Thor
		package_name 'tpl'

    desc "config", "Create config and edit with $EDITOR"
    def config
      Configuration.save
      if !ENV['EDITOR'].to_s.empty? && !ENV['EDITOR'].nil?
        exec "$EDITOR #{ENV['HOME']}/.tplinkadmin"
      else
        puts "$EDITOR is not set. Please type your editor:"
        editor = STDIN.gets.chomp
        exec "#{editor} #{ENV['HOME']}/.tplinkadmin"
      end
    end

    # desc "status", "Status"
    # def status
		# 	payload = "[WAN_DSL_INTF_CFG#1,0,0,0,0,0#0,0,0,0,0,0]0,12\r\nstatus\r\nmodulationType\r\nX_TPLINK_AdslModulationCfg\r\nupstreamCurrRate\r\ndownstreamCurrRate\r\nX_TPLINK_AnnexType\r\nupstreamMaxRate\r\ndownstreamMaxRate\r\nupstreamNoiseMargin\r\ndownstreamNoiseMargin\r\nupstreamAttenuation\r\ndownstreamAttenuation\r\n[WAN_DSL_INTF_STATS_TOTAL#1,0,0,0,0,0#0,0,0,0,0,0]1,8\r\nATUCCRCErrors\r\nCRCErrors\r\nATUCFECErrors\r\nFECErrors\r\nSeverelyErroredSecs\r\nX_TPLINK_US_SeverelyErroredSecs\r\nerroredSecs\r\nX_TPLINK_US_ErroredSecs\r\n"
    #   response = Client.post '/cgi?1&5', binary: payload
    #   Iniparse.parse(response)["[1,0,0,0,0,0]0"].each do |key,value|
    #     puts(sprintf "%-40s %-20s", key, value)
    #   end
    #   Configuration.save
    # end

    # desc "hosts", "show hostnames that are connected"
    # def hosts
    #   payload = "[LAN_HOST_ENTRY#0,0,0,0,0,0#0,0,0,0,0,0]0,4\r\nleaseTimeRemaining\r\nMACAddress\r\nhostName\r\nIPAddress\r\n"
    #   response = Client.post '/cgi?5', binary: payload
    #   Iniparse.new(response).parse.to_a.tap(&:pop).each do |_,data|
    #     Configuration.instance.hosts[data['MACAddress']] ||= {}
    #     Configuration.instance.hosts[data['MACAddress']][:host_name] = data['hostName']
    #   end
    #   Configuration.instance.hosts.each do |mac, host|
    #     puts(sprintf "%-16s %30s %30s", host[:ip_address], host[:host_name], host[:name])
    #   end

    #   Configuration.save
    # end

		# desc "traffic", "show traffic stats for individual hosts"
  #   def traffic
  #     payload = "[STAT_CFG#0,0,0,0,0,0#0,0,0,0,0,0]0,0\r\n[STAT_ENTRY#0,0,0,0,0,0#0,0,0,0,0,0]1,0\r\n"
  #     response = Client.post '/cgi?1&5', binary: payload
  #     structure = Iniparse.parse(response).to_a
  #     # remove first & last
  #     structure.shift; structure.pop

  #     Configuration.instance.hosts ||= {}
  #     Configuration.instance.hosts.each do |mac, host|
  #       host[:current_bytes] = 0
  #     end
  #     structure.each do |_, data|
		# 		Configuration.instance.hosts[ data['macAddress'] ] ||= {}
		# 		Configuration.instance.hosts[ data['macAddress'] ][:ip_address] = num2ip(data['ipAddress'])
		# 		Configuration.instance.hosts[ data['macAddress'] ][:total_bytes] = data['totalBytes']
		# 		Configuration.instance.hosts[ data['macAddress'] ][:current_bytes] = data['currBytes']
  #     end

  #     length = Configuration.instance.hostname_length ||= 16
  #     Configuration.instance.hosts.each do |mac, host|
  #       string = (host[:name] || host[:host_name] || "").chars.take(length).join
  #       puts(sprintf "%-16s %#{length}s %8.1f kb/10s %6.1f kb/s",  host[:ip_address], string, host[:current_bytes] / 1024, host[:current_bytes] / 10024)
  #     end
  #     Configuration.save
  #   end

    desc "reboot", "Reinicia o modem"
    def reboot
      result = Client.get "SysRebootRpm.htm?Reboot=Reboot"
      puts result.status
    end

    private
    def num2ip(num)
      "#{((num >> 24) + 256) % 256}.#{(num >> 16 & 0xff)}.#{(num >> 8 & 0xff)}.#{(num & 0xff)}"
    end

  end
end
