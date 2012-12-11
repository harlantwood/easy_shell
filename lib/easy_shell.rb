require "easy_shell/version"

module EasyShell
  def run(cmd, options = {})
    defaults = {
      :quiet => false,
      :confirm_first => false,
      :continue_on_failure => false,
      :return_result => false
    }
    unknown_options = options.keys - defaults.keys
    raise "Unknown options #{unknown_options.inspect}" unless unknown_options.empty?
    options = defaults.merge(options)
    cmd.gsub!(/\s+/, ' ')
    cmd.strip!
    cmd_sanitized = cmd.gsub(%r{(https://[-\w]+:)[-\w]+@}, '\1[password sanitized]@')
    puts "=> Running #{cmd_sanitized.inspect}\n" unless options[:quiet]

    return unless confirm("Execute [Yn]? ") if options[:confirm_first]

    if options[:quiet] || options[:return_result]
      cmd = "#{cmd} 2>&1"
      output = `#{cmd}`
      success = $?.success?
      puts output if success && !options[:quiet]
    else
      success = system(cmd)
      output = nil # output was already printed by system(...)
    end
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

  def confirm(msg)
    STDOUT << "#{msg} [Yn] "
    response = STDIN.gets.chomp
    response.empty? || !!response.match(/^(y|yes)$/i)
  end
end
