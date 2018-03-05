# frozen_string_literal: true

module IDMapper
  class Scheme
    attr_reader :id, :name

    def initialize(id:, name:)
      @id = id
      @name = name
    end
  end
end
