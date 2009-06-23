class Analytics < ToolSearcher
  
  def self.requirement
    has?("Google Analytics") do
      Matcher.any_file_includes_text?('(ga\.js)|(urchin\.js)', :in => :views)
    end
    
    has?("CrazyEgg") do
      Matcher.any_file_includes_text?('crazyegg.com', :in => :views)
    end
  end
end