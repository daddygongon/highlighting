# -*- coding: utf-8 -*-
require 'thor'

# Highlighting::Models
module Highlighting
  # CLI
  #
  # Highlightingのコマンドライン
  class CLI < Thor
    class_option :help, type: :boolean, aliases: '-h', desc: 'help message.'
    class_option :version, type: :boolean, desc: 'version'
    class_option :debug, type: :boolean, aliases: '-d', desc: 'debug mode'

    desc 'dummy', 'dummy'
    def main(argv)
      p argv
      puts Highlighting::main(argv)
      exit
    rescue => e
      output_error_if_debug_mode(e)
      exit(false)
    end
    default_task :main

    desc 'version', 'version'
    def version
      puts Highlighting::VERSION
    end

    private

    def output_error_if_debug_mode(e)
      return unless options[:debug]
      STDERR.puts(e.message)
      STDERR.puts(e.backtrace)
    end
  end
end
