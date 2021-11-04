# frozen_string_literal: true
require 'command_line/global'
require 'tempfile'
require_relative "highlighting/version"

module Highlighting
  class Error < StandardError; end
  # Your code goes here...
  module_function

  def select_theme
    if  ENV["TERM_PROGRAM"]=="Apple_Terminal"
      res = command_line "defaults read -g AppleInterfaceStyle"
      theme = res.stdout.chomp == 'Dark' ? 'andes.theme' :
        'seashell.theme'
    else
      theme = 'andes.theme'
    end
    return File.join(File.dirname(__FILE__), 'themes', theme)
  end

  theme = select_theme()
  p ARGV
  file = ARGV.shift
  if file == nil
    puts "No file assigned."
#    file = "./tmp_hoge.rb"

    Tempfile.open(['lightning', '.rb']) do |f1|
      p file = f1.path
      break unless FileTest.pipe?(STDIN)

      idx = 0
      while str = $stdin.gets
        f1.print "#{idx} #{str}"
        #      $stdout.print "#{idx} #{str}"
        idx += 1
      end

    end
  end
  p file
  comm = "highlight -O xterm256 #{file} --config-file=#{theme}"
  comm += " --syntax=ruby"
  system comm
end

