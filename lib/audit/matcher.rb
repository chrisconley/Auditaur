require 'active_support'
module Matcher
  
  class << self
  
    def constant_defined?(string)
      begin
        return true if string.constantize
      rescue NameError
        false
      end
    end
  
    def file_includes_text?(regex, options)
      file = options[:in].is_a?(Symbol) ? FileManager.send(options[:in]) : options[:in]
      !!File.read(file).match(/(#{regex})/mi)
    end

    def all_files_include_text?(regex, options)
      all_files_include_article?('method', regex, options)
    end
    
    def any_file_includes_text?(regex, options)
      files = FileManager.send(options[:in])
      files.each do |file|
        return true if file_includes_text?(regex, options.merge(:in => file))
      end
      false
    end
    
    private
    def all_files_include_article?(article, identifier, options)
      files = FileManager.send(options[:in])
      files.each do |file|
        file_options = options.merge(:in => file)
        return false if !self.send("file_includes_#{article}?".to_sym, identifier, file_options)
      end
      true
    end
  end
end