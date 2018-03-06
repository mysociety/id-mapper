# frozen_string_literal: true

require_relative '../test_helper'

describe IDMapper::Record do
  let(:scheme) { IDMapper::Scheme.new(id: 1, name: 'uk-area-id') }
  let(:record) { IDMapper::Record.new(id: 'gss:S17000017', scheme: scheme) }
  let(:other_scheme) { IDMapper::Scheme.new(id: 2, name: 'wikidata-district-item') }
  let(:other_record) { IDMapper::Record.new(id: 'Q1529479', scheme: other_scheme) }

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
      new_scheme = IDMapper::Scheme.new(id: 3, name: 'new-scheme')
      assert_nil record.get(new_scheme)
    end

    it 'raises error when scheme is that same' do
      assert_raises(IDMapper::InvalidScheme) do
        record.get(scheme)
      end
    end
  end

  describe '#all' do
    before { VCR.insert_cassette('id_mapper_record_all') }
    after { VCR.eject_cassette }

    it 'returns array of identifier values' do
      assert_equal ['Q1529479'], record.all(other_scheme)
    end

    it 'returns empty array when there is no equivalence claim' do
      new_scheme = IDMapper::Scheme.new(id: 3, name: 'new-scheme')
      assert_equal [], record.all(new_scheme)
    end

    it 'raises error when scheme is that same' do
      assert_raises(IDMapper::InvalidScheme) do
        record.all(scheme)
      end
    end
  end

  describe '#set' do
    let(:record) { IDMapper::Record.new(id: 'gss:S14000003', scheme: scheme) }
    let(:other_record) { IDMapper::Record.new(id: 'Q408547', scheme: other_scheme) }

    it 'returns true when equivalence claim is created' do
      VCR.use_cassette('id_mapper_record_set') do
        assert_nil record.get(other_scheme)
        assert_equal true, record.set(other_record)
        assert_equal 'Q408547', record.get(other_scheme)
      end
    end

    it 'accpets optional comment' do
      VCR.use_cassette('id_mapper_record_set_comment') do
        assert_equal true, record.set(other_record, comment: 'Some comment')
      end
    end
  end
end
