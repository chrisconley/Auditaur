class Analytics < ToolSearcher
  
  def self.requirement
    has?("Google Analytics") do
      Matchers.any_file_includes_text?('(ga\.js)|(urchin\.js)', :in => :views)
    end
    
    has?("CrazyEgg") do
      Matchers.any_file_includes_text?('crazyegg.com', :in => :views)
    end
  end
end