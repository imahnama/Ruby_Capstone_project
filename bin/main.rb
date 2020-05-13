#!/usr/bin/env ruby
require_relative '../lib/html_linter.rb'

lint = MyLint.new
lint.validate
