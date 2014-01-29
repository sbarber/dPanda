# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")

require 'motion/project/template/osx'
require 'awesome_print_motion'
require 'bubble-wrap/http'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  app.name = 'dPanda'
  app.info_plist['LSUIElement'] = true
  app.version = 0.3
end
