begin
  require File.join(File.dirname(__FILE__), '..', 'ext','bsdiff')
rescue Exception => e
  puts "Got exception trying to load native extension.  Did everything compile properly?"
  puts e.message
  puts "\t#{e.backtrace.join("\t\n")}\n"
end

module BSDiff
  def self.version
    return '0.1.1'
  end
end
