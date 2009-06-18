class SqlInjection < ToolSearcher
  def self.requirement
    does_not_have?("Sql injection vulnerabilities") do
      Matchers.any_file_includes_text?(':conditions\s+=>\s+((\"#\{.*\")|((\".*\"\s*\+\s*)*[a-zA-Z]))', :in => :entire_app)
    end
  end
  
  def self.failed_message
    "Whoops, we found possible vulnerabilities"
  end
  
  def self.passed_message
    "Great! There were no sql injection vulnerabilities found."
  end
end