# frozen_string_literal: true

require_relative './id_mapper/record'
require_relative './id_mapper/request'
require_relative './id_mapper/scheme'

module IDMapper
  InvalidScheme = Class.new(ArgumentError)

  class << self
    def schemes
      Request.get('scheme')[:results].map { |r| Scheme.new(r) }
    end

    def scheme(scheme_name)
      scheme = schemes.find { |s| s.name == scheme_name }
      raise InvalidScheme, 'scheme no present' unless scheme
      scheme
    end
  end
end
