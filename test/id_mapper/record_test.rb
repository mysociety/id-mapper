# frozen_string_literal: true

require_relative '../test_helper'

describe IDMapper::Record do
  let(:scheme) { OpenStruct.new(id: 1, name: 'wikidata-persons') }
  let(:record) { IDMapper::Record.new(id: 'Q6653712', scheme: scheme) }

  describe 'initialisation' do
    it 'sets ID attibutes' do
      assert_equal 'Q6653712', record.id
    end

    it 'sets scheme attibutes' do
      assert_equal scheme, record.scheme
    end
  end
end
