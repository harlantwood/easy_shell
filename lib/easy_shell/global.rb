require_relative "../easy_shell"

module Kernel
  def run(cmd, options = {})
    EasyShell.run cmd, options
  end
end
