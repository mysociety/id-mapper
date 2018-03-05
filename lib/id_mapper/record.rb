# frozen_string_literal: true

module IDMapper
  class Record
    attr_reader :id, :scheme

    def initialize(id:, scheme:)
      @id = id
      @scheme = scheme
    end

    def get(other_scheme)
      raise InvalidScheme, 'scheme must differ' if scheme == other_scheme
      identifier = identifiers.find { |i| i.scheme.id == other_scheme.id }
      identifier.to_s if identifier
    end

    private

    def identifiers
      path = "identifier/#{scheme.id}/#{id}"
      Request.get(path)[:results].map { |r| Identifier.new(r) }
    end
  end
end
