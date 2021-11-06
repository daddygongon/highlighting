require 'spec_helper'

RSpec.describe 'highlight command', type: :aruba do
  context 'echo hello' do
    before(:each) { run_command('echo hello') }
    it { expect(last_command_started).to be_successfully_executed }
    it { expect(last_command_started).to have_output("hello") }
  end

  context 'version option' do
    before(:each) { run_command ('highlighting v') }
    it { expect(last_command_started).to be_successfully_executed }
    it { expect(last_command_started).to have_output("0.1.0") }
  end
end
