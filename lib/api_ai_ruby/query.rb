require 'net/http'
require 'uri'
require 'json'

class ApiAiRuby
  class ApiClient
    def initialize(obj)
      @properties = obj
      uri = URI.parse(BASE_URL)
      @https = Net::HTTP.new(uri.host, uri.port)
      @https.use_ssl = true
      @req = Net::HTTP::Post.new(uri.request_uri)
      @req["Authorization"] = "Bearer #{obj.access_token}"        
      @req["ocp-apim-subscription-key"] = obj.subscription_key    
      @req["Content-Type"] = "application/json"
      @req
    end
  
    def query(str)
      payload = {:q => str, :lang => @properties.lang}.to_json
      @req.body = payload
      res = @https.request @req
      JSON.parse(res.body, {:symbolize_names => true})
    end
  end
end