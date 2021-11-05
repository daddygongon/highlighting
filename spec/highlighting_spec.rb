# frozen_string_literal: true

RSpec.describe Highlighting do
  include Highlighting
  it "has a version number" do
    expect(Highlighting::VERSION).not_to be nil
  end

  it "selct_theme w 'nil' should return the appropriate dir" do
    expected = File.join(File.dirname(__FILE__),
                           'themes', 'andes.theme')
    expected.sub!('spec', 'lib')
    expect(expected).to eq select_theme(nil)
  end

  it "selct_theme w 'Apple_Terminal' should return andes or seashell" do
    theme = command_line("defaults read -g AppleInterfaceStyle").stdout.chomp ==
      'Dark' ? 'andes.theme' : 'seashell.theme'
    expected = File.join(File.dirname(__FILE__),
                           'themes', theme)
    expected.sub!('spec', 'lib')
    expect(expected).to eq select_theme('Apple_Terminal')
  end

end
