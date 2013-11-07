module AmericommerceApi
  class Response
    def self.format(response, call_action)
      call_action = call_action.to_s
      response = response.body ? response.body["#{call_action}_response".to_sym] : nil
      return response ? response["#{call_action}_result".to_sym] : nil
    end
  end
end