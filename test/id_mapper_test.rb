# frozen_string_literal: true

require_relative './test_helper'

describe IDMapper do
  before { VCR.insert_cassette('id_mapper') }
  after { VCR.eject_cassette }

  describe '.schemes' do
    it 'returns and array' do
      assert_instance_of Array, IDMapper.schemes
    end

    it 'maps scheme data correctly' do
      schemes = IDMapper.schemes
      assert_instance_of IDMapper::Scheme, schemes.first
      assert_equal 1, schemes.first.id
      assert_equal 'uk-area_id', schemes.first.name
    end
  end

  describe '.scheme' do
    it 'raises error when scheme is invalid' do
      assert_raises(IDMapper::InvalidScheme) do
        IDMapper.scheme(scheme: 'invalid')
      end
    end

    it 'returns scheme with given name' do
      scheme = IDMapper.scheme('uk-area_id')
      assert_instance_of IDMapper::Scheme, scheme
      assert_equal 1, scheme.id
      assert_equal 'uk-area_id', scheme.name
    end
  end
end
