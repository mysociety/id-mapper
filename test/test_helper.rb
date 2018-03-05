# frozen_string_literal: true

require 'minitest/autorun'
require 'mocha/setup'
require 'vcr'
require 'webmock'

VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock
end

ENV['ID_MAPPING_STORE_BASE_URL'] = 'http://127.0.0.1:8000'

require_relative '../lib/id_mapper'
