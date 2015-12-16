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
      http = Curl.get("http://#{host}#{path}") do |curl|
        curl.headers['User-Agent'] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.86 Safari/537.36'
        curl.headers['Accept-Language'] = 'de-DE,de;q=0.8,en-US;q=0.6,en;q=0.4,zh-CN;q=0.2'
        curl.headers['Accept-Encoding'] = 'gzip, deflate, sdch'
        curl.headers['Content-Type'] = 'text/plain'
        curl.headers['Accept'] = '*/*'
        curl.headers['Referer'] = "http://#{host}/"
        curl.headers['Cookie'] = "Authorization=Basic #{password}"
        curl.headers['Connection'] = 'keep-alive'
      end
      if http.status.to_i > 399
        $stderr.puts "Invalid statuscode: #{http.status}"
        $stderr.puts http.body
        exit 1
      end
      http.body
    end

  end
end
