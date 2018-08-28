# frozen_string_literal: true

require_relative './id_mapper/record'
require_relative './id_mapper/request'
require_relative './id_mapper/scheme'

module IDMapper
  InvalidScheme = Class.new(ArgumentError)

  class << self
    attr_accessor :logger

    def schemes
      Request.get('scheme')[:results].map { |r| Scheme.new(r) }
    end

    def scheme(scheme_name)
      scheme = schemes.find { |s| s.name == scheme_name }
      raise InvalidScheme, 'scheme not present' unless scheme
      scheme
    end

    def log(level, message)
      logger&.send(level, name) { message }
    end
  end
end
