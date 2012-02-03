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
  
  describe 'exists?' do
    it "should return true if host is listed" do
      cmd_exec = mock(Toft::CommandExecutor.class)
      cmd_exec.should_receive(:cmd).with("lxc-ls").and_return(/host/)

      Toft::LxcCommand.new(cmd_exec).exists?("host").should be_true
    end

    it "should return false if host is not listed" do
      cmd_exec = mock(Toft::CommandExecutor.class)
      cmd_exec.should_receive(:cmd).with("lxc-ls").and_return(/host/)

      Toft::LxcCommand.new(cmd_exec).exists?("ubuntu").should be_false
    end
  end
end
