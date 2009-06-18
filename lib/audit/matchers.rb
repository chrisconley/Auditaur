require 'active_support'
module Matchers
  
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
    
    def file_includes_method?(name, options)
      option_regex = options[:with].blank? ? '' : ":#{options[:with]}\s=>"
      file = options[:in]
      file_includes_text?("#{name.to_s}.*#{option_regex}", :in => file)
    end
  
    def all_files_include_method?(name, options)
      all_files_include_article?('method', name, options)
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