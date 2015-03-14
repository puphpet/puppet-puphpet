dir = File.dirname(File.expand_path(__FILE__))
require "#{dir}/to_bool.rb"

#
# array_true.rb
#

module Puppet::Parser::Functions

  newfunction(:array_true, :type => :rvalue, :doc => <<-'ENDHEREDOC') do |args|

    Returns true if value in array exists and is truthy
    ENDHEREDOC

    unless args.length == 2
      raise Puppet::ParseError, ("array_true(): wrong number of arguments (#{args.length}; must be 2)")
    end

    container = args[0]

    if (!container.is_a?(Hash)) && (!container.is_a?(Array))
      raise Puppet::ParseError, ("value_true(): first value must be an array, passed #{container.class}")
    end

    key = args[1]

    if !container.has_key?(key)
      return false
    end

    if (container[key].is_a?(Hash)) || (container[key].is_a?(Array))
      return container[key].count > 0
    end

    return container[key].to_bool

  end
end
