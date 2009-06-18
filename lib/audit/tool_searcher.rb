class ToolSearcher
  class << self 
    def passed_message
      "Great! It looks like you have #{@tools.names_of_tools_found.join(' and ')} setup."
    end

    def failed_message
      names = @tools.map{|t| t[:name]}.join(", ")
      "Couldn't find a #{self.name}. Check out #{names}"
    end

    def has?(name)
      @tools << {:name => name, :exists => yield}
    end
    
    def does_not_have?(name)
      @tools << {:name => name, :exists => !yield}
    end

    def exists?
      puts "Looking for a #{self.name}"
      @tools = ToolCollection.new(self.name)
      requirement
      if @tools.map{|t| t[:exists]}.reject{|t| !t}.length > 0
        puts passed_message
      else
        puts failed_message
      end
    end
  end 
  
  module InstanceMethods 
  end

end
class ToolCollection < Array
  attr_accessor :name
  def initialize(name)
    @name = name
  end
  
  def names_of_tools_found
    tools_found.map{|t| t[:name]}
  end
  
  def tools_found
    reject{|t| !t[:exists]}
  end
end