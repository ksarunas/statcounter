module Statcounter
  class ParamsEncoder
    def initialize(credentials)
      @credentials = credentials || Statcounter.default_credentials
    end

    def encode(params)
      return unless params.is_a? Hash

      query_string = hash_to_query_string(request_params(params))
      sha1 = generate_sha1(query_string)

      "#{query_string}&sha1=#{sha1}"
    end

    private

    def request_params(params)
      params[:vn] ||= 3
      params[:t] ||= Time.now.to_i
      params[:u] ||= @credentials[:username]
      params[:f] ||= :json
      params
    end

    def hash_to_query_string(hash)
      hash.each_with_object('') do |(key, value), query_string|
        next value.each { |v| query_string << "#{key}=#{v}&" } if value.is_a? Array

        query_string << "#{key}=#{value}&"
      end.chomp('&')
    end

    def generate_sha1(query_string)
      Digest::SHA1.hexdigest('?' + query_string + @credentials[:secret])
    end
  end
end
