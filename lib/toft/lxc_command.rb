module Toft
  class LxcCommand

    include Toft::CommandExecutor

    def create(options = {})
      cmd! "lxc-create -n #{options[:hostname]} -f #{options[:conf]} -t #{options[:type].to_s}" 
    end

    def exists?(hostname)
      return cmd("lxc-ls") =~ /#{hostname}/
    end
  end
end
