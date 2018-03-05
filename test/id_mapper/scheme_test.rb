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

  describe '#[]' do
    it 'returns Record object' do
      assert_instance_of IDMapper::Record, scheme['Q1']
    end

    it 'sets Record ID attribute' do
      assert_equal 'Q1', scheme['Q1'].id
    end

    it 'sets Record scheme attribute' do
      assert_equal scheme, scheme['Q1'].scheme
    end
  end
end
