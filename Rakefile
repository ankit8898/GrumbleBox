# -*- coding: utf-8 -*-

$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'rubygems'
require 'motion-cocoapods'
require 'nano-store'
require 'bubble-wrap'

Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'GrumbleBox'
  app.icons << "grumbleicon.png"
  app.info_plist['UIStatusBarHidden'] = true
  app.pods do
    pod 'NanoStore', '~> 2.6.0'
  end
end
