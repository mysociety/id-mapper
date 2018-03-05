# frozen_string_literal: true

module IDMapper
  class Scheme
    attr_reader :id, :name

    def initialize(id:, name:)
      @id = id
      @name = name
    end

    def [](id)
      Record.new(id: id, scheme: self)
    end
  end
end
