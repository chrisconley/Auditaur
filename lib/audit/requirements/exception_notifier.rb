class ExceptionNotifier < ToolSearcher

  def self.requirement
    has?("Exceptional") do
      Matchers.constant_defined?("Exceptional")
    end

    has?("Hoptoad") do
      Matchers.constant_defined?("HoptoadNotifier")
    end
    
    has?("Exception Notification") do
      Matchers.file_includes_text?('include ExceptionNotifiable', :in => :application_controller)
    end
  end
end