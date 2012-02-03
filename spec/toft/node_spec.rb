require 'spec_helper'

describe "Node" do

  describe 'run_puppet' do

    it 'should run block with puppet runner' do
      lxc_command = mock(Toft::LxcCommand.class)
      lxc_command.stub! :create
      lxc_command.stub! :exists?

      puppet_runner = mock Toft::Puppet::PuppetRunner.class
      puppet_runner.should_receive(:run).with('manifest', {})
      
      node = Toft::Node.new(lxc_command, "my_host", {:runner => puppet_runner})
      node.run_puppet('manifest')
    end

  end

end
