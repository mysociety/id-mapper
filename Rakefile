# frozen_string_literal: true

require 'rake/testtask'
require 'rubocop/rake_task'

task default: %i[test rubocop]

Rake::TestTask.new { |t| t.pattern = './test/**/*_test.rb' }
RuboCop::RakeTask.new
