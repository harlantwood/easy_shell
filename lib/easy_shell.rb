require "easy_shell/version"

module EasyShell
  def self.run(cmd, options = {})
    defaults = {
      :quiet => false,
      :confirm_first => false,
      :continue_on_failure => false,
      :stdout_only => false,
    }
    unknown_options = options.keys - defaults.keys
    raise "Unknown options #{unknown_options.inspect}" unless unknown_options.empty?
    options = defaults.merge(options)
    cmd.gsub!(/\s+/, ' ')
    cmd.strip!
    cmd_sanitized = cmd.gsub(%r{(https://[-\w]+:)[-\w]+@}, '\1[password sanitized]@')
    puts "---> #{cmd_sanitized}\n" unless options[:quiet]

    if options[:confirm_first]
      return unless confirm("Execute?")
    end

    cmd = "#{cmd} 2>&1" unless options[:stdout_only]
    output = %x(#{cmd})
    success = $?.success?
    puts output if success && !options[:quiet]

    unless success
      if options[:continue_on_failure]
        msg = "Continuing, ignoring error while running #{cmd_sanitized.inspect}"
        msg += "\nOutput:\n#{output}" if output
        puts msg
      else
        msg = "ERROR running #{cmd_sanitized.inspect}"
        msg += "\nOutput:\n#{output}" if output
        raise msg
      end
    end
    output
  end

  def self.confirm(msg)
    STDOUT << "#{msg} [Yn] "
    response = STDIN.gets.chomp
    response.empty? || !!response.match(/^(y|yes)$/i)
  end
end
