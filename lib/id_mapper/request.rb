# frozen_string_literal: true

require 'json'
require 'rest-client'

module IDMapper
  class Request
    ID_MAPPING_STORE_BASE_URL = ENV.fetch(
      'ID_MAPPING_STORE_BASE_URL', 'https://id-mapping-store.mysociety.org'
    )

    def self.get(path)
      url = "#{ID_MAPPING_STORE_BASE_URL}/#{path}"
      parse(RestClient.get(url, headers))
    end

    def self.headers
      { content_type: :json, accept: :json }
    end
    private_class_method :headers

    def self.parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
    private_class_method :parse
  end
end
