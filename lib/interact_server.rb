require 'net/http'

class InteractServer

  ##
  ## @brief      { Get the word on the param url }
  ##
  ## @param      url   { String }
  ## @param      args  { String }
  ##
  ## @return     { String }
  ##
  def call_to_the_url(url, *args)
    url = URI.parse("#{url}#{args.join("&")}")
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    res.body
  end

end
