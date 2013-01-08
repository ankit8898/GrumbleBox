# -*- coding: utf-8 -*-

$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'rubygems'
require 'motion-cocoapods'
require 'nano-store'

Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'GrumbleBox'
  app.icons << "grumble.jpg"

  app.pods do
    pod 'NanoStore', '~> 2.5.3'
  end
end
