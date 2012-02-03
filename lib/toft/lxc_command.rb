module Toft
  class LxcCommand

    def initialize(command_executor)
      @command_executor = command_executor
    end

    def create(options = {})
      @command_executor.cmd! "lxc-create -n #{options[:hostname]} -f #{options[:conf]} -t #{options[:type].to_s}" 
    end

    def exists?(hostname)
      return @command_executor.cmd("lxc-ls") =~ "/#{hostname}/"
    end
  end
end
