# frozen_string_literal: true
require "highlighting/version"
require "cli"
require "command_line/global"
require "tempfile"

module Highlighting
  class Error < StandardError; end

  # Your code goes here...
  module_function

  def main(argv)
    theme = select_theme(ENV["TERM_PROGRAM"])
    file = if FileTest.pipe?(STDIN)
        mk_temp_file
      else
        tmp = argv.class == Array ? argv.shift : argv
        tmp == "test/highlighting_test.rb" ? nil : tmp
      end
    return "no file or pipe assigned." if file == nil

    comm = "highlight -O xterm256 #{file} --config-file=#{theme}"
    comm += " --syntax=ruby"
    command_line(comm).stdout.chomp #return
  end

  def select_theme(term_program = nil)
    theme = if term_program == "Apple_Terminal"
        res = command_line "defaults read -g AppleInterfaceStyle"
        theme = res.stdout.chomp == "Dark" ? "andes.theme" :
          "seashell.theme"
      else
        "andes.theme"
      end
    return File.join(File.dirname(__FILE__), "themes", theme)
  end

  def mk_temp_file
    Tempfile.open(["highlighting", ".rb"]) do |f1|
      idx = 0
      while str = STDIN.gets
        f1.print "#{idx} #{str}"
        idx += 1
      end
      f1.path # return file_path
    end
  end
end
