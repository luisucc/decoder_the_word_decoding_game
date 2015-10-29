require 'net/http'

class InteractServer

  attr_accessor

  def call_to_the_url(url, *args)
    url = URI.parse("#{url}#{args.join("&")}")
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    res.body
  end

end
