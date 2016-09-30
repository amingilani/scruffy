#!/usr/bin/env ruby
# require 'byebug'

project_root = File.dirname(__FILE__)
require "#{project_root}/lib/test_runner.rb"
require "#{project_root}/lib/adsl_stats.rb"

speed_test = TestRunner.new.to_data
adsl_test = AdslStats.new.result

test_results = {
  speed_test: speed_test,
  adsl_test: adsl_test
}

folder = "#{project_root}/logs"
date = "#{Time.now.year}-#{Time.now.month}"

FileUtils.mkdir_p(folder) unless File.directory?(folder)
line = test_results.to_json

open("#{folder}/#{date}.log", 'a') do |f|
  f << "#{line}\n"
end
