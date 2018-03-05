# frozen_string_literal: true

require_relative '../test_helper'

describe IDMapper::Scheme do
  let(:scheme) { IDMapper::Scheme.new(id: 1, name: 'wikidata-persons') }

  describe 'initialisation' do
    it 'sets ID attibutes' do
      assert_equal 1, scheme.id
    end

    it 'sets name attibutes' do
      assert_equal 'wikidata-persons', scheme.name
    end
  end
end
