# frozen_string_literal: true

module IDMapper
  class Identifier
    attr_reader :scheme, :value

    def initialize(scheme_id:, scheme_name:, value:)
      @scheme = Scheme.new(id: scheme_id, name: scheme_name)
      @value = value
    end

    def to_s
      @value
    end
  end
end
