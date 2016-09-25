#!/usr/bin/env ruby
project_root = File.dirname(__FILE__)
require "#{project_root}/lib/test_runner.rb"

test = TestRunner.new
test.save_to_file "#{project_root}/logs"
