module AmericommerceApi
  class Api

    AUTHENTICATE_WSDL = File.read(File.expand_path('../wsdl/americommercedb.asmx.wsdl', __FILE__))
    WSDL_POSTFIX = '/store/ws/AmeriCommerceDb.asmx?wsdl'

    NAMESPACES = {
        'xmlns' => 'http://www.americommerce.com'
    }


    def initialize(options)

      @log_level = options[:log_level] || :warn
      @ac_header = {
          'AmeriCommerceHeaderInfo' => {
              'UserName' => options[:username],
              'Password' => options[:password],
              'SecurityToken' => options[:token]
          }
      }

      @store_domain = options[:store_domain] + WSDL_POSTFIX

      init_client(@ac_header, @store_domain)
    end

    def get_orders(options = {})
      start_date = options[:start_date] || DateTime.new
      end_date = options[:end_date] || DateTime.now
      request(:order_get_by_edit_date_range_pre_filled, {'pdtStartDateTime' => start_date.to_datetime, 'pdtEndDateTime' => end_date.to_datetime})
    end

    def get_product_by_id(product_id)
      request(:product_get_by_key, {'piitemID' => product_id})
    end

    def get_product_url(product_id)
      request(:product_get_current_url, {'piProductID' => product_id})
    end

    def get_all_order_statuses
      request(:order_status_get_all)
    end

    def ping
      begin
        wsdl = AUTHENTICATE_WSDL % {store_domain: @store_domain}
        init_client(@ac_header,wsdl)
        response = request(:authenticate)
        raise AmericommerceApi::Exceptions::InvalidCredentials unless response == true
      rescue
        raise AmericommerceApi::Exceptions::InvalidCredentials
      ensure
        init_client(@ac_header, @store_domain)
      end
    end

    private

    def request(call_action, request_params={})
      response = @client.call(call_action, message: request_params)
      return AmericommerceApi::Response.format(response, call_action)
    end

    def init_client(ac_header, wsdl)
      @client = Savon.client({
                                 :ssl_verify_mode  => :none,
                                 :wsdl             => wsdl,
                                 :soap_header      => ac_header,
                                 :namespaces       => NAMESPACES,
                                 :log_level        => @log_level
                             })
    end

  end
end