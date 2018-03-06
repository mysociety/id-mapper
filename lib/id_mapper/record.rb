# frozen_string_literal: true

module IDMapper
  class Record
    attr_reader :id, :scheme
    alias to_s id

    def initialize(id:, scheme:)
      @id = id
      @scheme = scheme
    end

    def to_h
      { scheme_id: scheme.id, value: id }
    end

    def get(other_scheme)
      all(other_scheme).first
    end

    def all(other_scheme)
      identifiers_for_scheme(other_scheme).map(&:to_s)
    end

    def set(record, options = {})
      params = options.merge(
        identifier_a: { scheme_id: scheme.id, value: id },
        identifier_b: { scheme_id: record.scheme.id, value: record.id }
      )
      response = Request.post('equivalence-claim', params)
      response.code == 201
    end

    private

    def identifiers_for_scheme(other_scheme)
      raise InvalidScheme, 'scheme must differ' if scheme == other_scheme
      identifiers.select { |i| i.scheme.id == other_scheme.id }
    end

    def identifiers
      path = "identifier/#{scheme.id}/#{id}"
      Request.get(path)[:results].map do |r|
        other_scheme = Scheme.new(id: r[:scheme_id], name: r[:scheme_name])
        Record.new(id: r[:value], scheme: other_scheme)
      end
    end
  end
end
