$:.unshift File.dirname(__FILE__)
require 'audit/file_manager'
require 'audit/matchers'
require 'audit/tool_searcher'

Dir.glob(File.join(File.dirname(__FILE__), 'audit/requirements/*.rb')).each {|f| require f }

module Audit
  class << self
    include FileManager
    include Matchers
    
    def app_root
      RAILS_ROOT
    end
  end
end