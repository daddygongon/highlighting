# frozen_string_literal: true

require "test_helper"

class HighlightingTest < Test::Unit::TestCase
  include Highlighting
  test "VERSION" do
    assert do
      ::Highlighting.const_defined?(:VERSION)
    end
  end

  test "check selct_theme with arg = nil" do
    expected = File.join(File.dirname(__FILE__),
                           'themes', 'andes.theme')
    expected.sub!('test', 'lib')
    assert_equal(expected, select_theme(nil))
  end
  test "check selct_theme with arg = 'Apple_Terminal'" do
    theme = command_line("defaults read -g AppleInterfaceStyle").stdout.chomp ==
      'Dark' ? 'andes.theme' : 'seashell.theme'
    expected = File.join(File.dirname(__FILE__),
                           'themes', theme)
    expected.sub!('test', 'lib')
    assert_equal(expected, select_theme('Apple_Terminal'))
  end
end
