# frozen_string_literal: true

require_relative '../test_helper'

describe IDMapper::Record do
  let(:scheme) { OpenStruct.new(id: 1, name: 'uk-area-id') }
  let(:record) { IDMapper::Record.new(id: 'gss:S17000017', scheme: scheme) }
  let(:other_scheme) { OpenStruct.new(id: 2, name: 'wikidata-district-item') }

  describe 'initialisation' do
    it 'sets ID attibutes' do
      assert_equal 'gss:S17000017', record.id
    end

    it 'sets scheme attibutes' do
      assert_equal scheme, record.scheme
    end
  end

  describe '#get' do
    before { VCR.insert_cassette('id_mapper_record_get') }
    after { VCR.eject_cassette }

    it 'returns identifier value' do
      assert_equal 'Q1529479', record.get(other_scheme)
    end

    it 'returns nil value when there is no equivalence claim' do
      new_scheme = OpenStruct.new(id: 3, name: 'new-scheme')
      assert_nil record.get(new_scheme)
    end

    it 'raises error when scheme is that same' do
      assert_raises(IDMapper::InvalidScheme) do
        record.get(scheme)
      end
    end
  end
end
