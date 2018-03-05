# frozen_string_literal: true

require_relative './id_mapper/request'
require_relative './id_mapper/scheme'

module IDMapper
  def self.schemes
    Request.get('scheme')[:results].map { |r| Scheme.new(r) }
  end
end
