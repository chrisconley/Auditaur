class AttrAccessible < ToolSearcher
  def self.requirement
    has?("Attr_accessible set in all active record models") do
      Matcher.all_files_include_text?(/attr_accessible/, :in => :ar_models)
    end
  end
  
  def self.failed_message
    "Uh oh. Looks like you're missing attr_accessible in at least one of your models. Shame on you!"
  end
  
  def self.passed_message
    "Awesome! You have attr_accessible in all of your models!"
  end
end