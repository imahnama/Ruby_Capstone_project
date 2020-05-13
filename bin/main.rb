#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/html_linter.rb'

lint = MyLint.new
lint.validate
