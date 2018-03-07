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

    def set(record, comment: nil)
      del(record.scheme)
      equivalence_claim(record, comment: comment)
    end

    def del(record_or_scheme)
      case record_or_scheme
      when Record
        equivalence_claim(record_or_scheme, deprecated: true)
      when Scheme
        identifiers_for_scheme(record_or_scheme).all? { |record| del(record) }
      end
    end

    private

    def equivalence_claim(record, options)
      response = Request.post(
        'equivalence-claim',
        options.merge(identifier_a: to_h, identifier_b: record.to_h).compact
      )

      (response.code == 201).tap do |success|
        update_identifiers(record, options) if success
      end
    end

    def identifiers_for_scheme(other_scheme)
      raise InvalidScheme, 'scheme must differ' if scheme == other_scheme
      identifiers.select { |i| i.scheme.id == other_scheme.id }
    end

    def identifiers
      @identifiers ||= load_identifiers
    end

    def load_identifiers
      path = "identifier/#{scheme.id}/#{id}"
      Request.get(path)[:results].map do |r|
        other_scheme = Scheme.new(id: r[:scheme_id], name: r[:scheme_name])
        Record.new(id: r[:value], scheme: other_scheme)
      end
    end

    def update_identifiers(record, options)
      if options[:deprecated]
        @identifiers -= [record]
      else
        @identifiers << record
      end
    end
  end
end
