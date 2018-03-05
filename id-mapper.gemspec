# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'id_mapper/version'

Gem::Specification.new do |s|
  s.name = 'id-mapper'
  s.version = IDMapper::VERSION
  s.summary = ''
  s.description = ''
  s.author = 'Graeme Porteous'
  s.email = 'democracy@mysociety.org'
  s.homepage = 'https://github.com/mysociety/id-mapper'
  s.license = 'MIT'

  s.add_dependency('json', '~> 2.1')
  s.add_dependency('rest-client', '~> 2.0')

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- test/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map do |f|
    File.basename(f)
  end
  s.require_paths = ['lib']
end
