class ForeignKeys < ToolSearcher

  def self.requirement
    has?("Foreign Key Constraints") 
  end
end