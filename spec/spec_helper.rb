require 'simplecov'
require 'simplecov-rcov-text'

class SimpleCov::Formatter::MergedFormatter
  def format(result)
    SimpleCov::Formatter::HTMLFormatter.new.format(result)
    SimpleCov::Formatter::RcovTextFormatter.new.format(result)
  end
end
SimpleCov.formatter = SimpleCov::Formatter::MergedFormatter

SimpleCov.start do
  add_filter '/features/'
end

require File.join( File.dirname( __FILE__ ), '..', 'lib/mensario' )
