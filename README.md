easy_shell
==========

Easily execute shell commands from ruby, with options like verbose output,
confirm first, and continue (or abort) on failure.

Installation
------------

Add this line to your application's Gemfile:

    gem 'easy_shell'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install easy_shell

Sample Usage
------------

    require 'easy_shell'

Vanilla usage

    > run "date +%M"
    => Running "date +%M"
    11
     => "11\n"

Quiet

    > run "date +%M", :quiet => true
     => "12\n"

Require interactive confirmation before executing command

    > run "date +%M", :confirm_first  => true
    => Running "date +%M"
    Execute [Yn]?  [Yn]
    13
     => "13\n"

    > run "date +%M", :confirm_first  => true
    => Running "date +%M"
    Execute [Yn]?  [Yn] n
     => nil

Raise exception when the command fails (not found or non-zero exit code)...

    > run "nosuchcommand"
    => Running "nosuchcommand"
    RuntimeError: ERROR running "nosuchcommand"
    Output:
    sh: nosuchcommand: command not found
        [stacktrace removed]

...unless we ask to continue on failure

    > run "nosuchcommand", :continue_on_failure => true
    => Running "nosuchcommand"
    Continuing, ignoring error while running "nosuchcommand"
    Output:
    sh: nosuchcommand: command not found
     => "sh: nosuchcommand: command not found\n"

Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
