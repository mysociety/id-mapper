# frozen_string_literal: true

module IDMapper
  class Record
    attr_reader :id, :scheme

    def initialize(id:, scheme:)
      @id = id
      @scheme = scheme
    end
  end
end
