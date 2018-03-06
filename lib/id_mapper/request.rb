# frozen_string_literal: true

require 'json'
require 'rest-client'

module IDMapper
  class Request
    ID_MAPPING_STORE_BASE_URL = ENV.fetch(
      'ID_MAPPING_STORE_BASE_URL', 'https://id-mapping-store.mysociety.org'
    )
    ID_MAPPING_STORE_API_KEY = ENV.fetch('ID_MAPPING_STORE_API_KEY')

    def self.get(path)
      url = "#{ID_MAPPING_STORE_BASE_URL}/#{path}"
      parse(RestClient.get(url, headers))
    rescue RestClient::NotFound
      { results: [] }
    end

    def self.post(path, params)
      url = "#{ID_MAPPING_STORE_BASE_URL}/#{path}"
      RestClient.post(url, params.to_json, headers_with_api_key)
    end

    def self.headers
      { content_type: :json, accept: :json }
    end
    private_class_method :headers

    def self.headers_with_api_key
      headers.merge(x_api_key: ID_MAPPING_STORE_API_KEY)
    end
    private_class_method :headers_with_api_key

    def self.parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
    private_class_method :parse
  end
end
