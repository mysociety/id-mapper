# frozen_string_literal: true

require_relative '../test_helper'

describe IDMapper::Identifier do
  let(:identifier) do
    IDMapper::Identifier.new(
      scheme_id: 1, scheme_name: 'wikidata-persons', value: 'Q1'
    )
  end

  describe 'initialisation' do
    it 'sets scheme attibutes' do
      assert_instance_of IDMapper::Scheme, identifier.scheme
      assert_equal 1, identifier.scheme.id
      assert_equal 'wikidata-persons', identifier.scheme.name
    end

    it 'sets value attibutes' do
      assert_equal 'Q1', identifier.value
    end
  end

  describe '#to_s' do
    it 'returns value' do
      assert_equal 'Q1', identifier.to_s
    end
  end
end
