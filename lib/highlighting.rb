# frozen_string_literal: true
require 'command_line/global'

require_relative "highlighting/version"

module Highlighting
  class Error < StandardError; end
  
  # Your code goes here...
  module_function
  
  def select_theme
    res = command_line "defaults read -g AppleInterfaceStyle"
    theme = if res.stdout.chomp == 'Dark'
              'andes.theme'
            else
              'seashell.theme'
            end
    return File.join(File.dirname(__FILE__), 'themes', theme)
  end

  # puts "Hello world."
  # p ARGV
  file = ARGV[0]
  theme = select_theme()
  # system "which highlight"
  system "highlight -O xterm256 #{file} --config-file=#{theme}"

end


