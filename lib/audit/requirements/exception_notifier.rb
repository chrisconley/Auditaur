class ExceptionNotifier < ToolSearcher

  def self.requirement
    has?("Exceptional") do
      Matcher.constant_defined?("Exceptional")
    end

    has?("Hoptoad") do
      Matcher.constant_defined?("HoptoadNotifier")
    end
    
    has?("Exception Notification") do
      Matcher.file_includes_text?('include ExceptionNotifiable', :in => :application_controller)
    end
  end
end