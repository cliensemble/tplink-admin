require 'tplink-admin/configuration'
require 'net/http'

module TplinkAdmin
  class Client
    def self.username
      Configuration.instance.username
    end

    def self.password
      Configuration.instance.password
    end

    def self.host
      Configuration.instance.url
    end

    def self.post(path, binary: nil)
      # curl 'http://192.168.178.1/cgi?1&5' -H 'Referer: http://192.168.178.1/' -H 'Cookie: Authorization=Basic cmVuc2hhbnJlbmhhaQ==' --data-binary $'[STAT_CFG#0,0,0,0,0,0#0,0,0,0,0,0]0,0\r\n[STAT_ENTRY#0,0,0,0,0,0#0,0,0,0,0,0]1,0\r\n' --compressed --verbose
      http = Net::HTTP.new(host, 80)
      request = Net::HTTP::Post.new(path)
      request.basic_auth username, password
      request.body = binary
      request.content_type = 'text/plain'
      request.add_field 'Referer', "http://#{host}/"
      request.add_field 'Cookie', "Authorization=Basic #{password}"

      res = http.request(request)
      if res.code.to_i > 399
        $stderr.puts "Invalid status code: #{res.code}"
        $stderr.puts res.body
        exit 1
      end
      res.body
    end

    def self.get(path)
      uri = URI("http://#{host}/userRpm/#{path}")
      # Redirecionamento de portas: http://192.168.1.1/userRpm/VirtualServerRpm.htm?Port=3383&Ip=192.168.1.104&Protocol=1&State=1&Commonport=0&Changed=0&SelIndex=0&Save=Save
      # Reboot: http://192.168.0.2/userRpm/SysRebootRpm.htm?Reboot=Reboot
      req = Net::HTTP::Get.new(uri)
      req.basic_auth username, password
      
      res = Net::HTTP.start(uri.hostname, uri.port) {|http|
        http.request(req)
      }
      
      res
    end

  end
end
