require 'spec_helper'

describe "LxcCommand" do

  describe 'create' do

    it "should create node with the provided options" do
      cmd_exec = mock(Toft::CommandExecutor.class)
      cmd_exec.should_receive(:cmd!).with("lxc-create -n host -f /tmp/conf -t natty")
      
      lxc_command = Toft::LxcCommand.new(cmd_exec)
      lxc_command.create({
        :hostname => "host",
        :conf => "/tmp/conf",
        :type => :natty
      })
    end

  end

end
