class UniqueIndexes < ToolSearcher

  # this is basically pseudo code right now
  # flawed right now if validates_uniqueness_of is not specified in the model (ex. authlogic)
  def self.requirement
    has?("Unique database indexes where validates_uniqueness_of is found") do
      FileManager.ar_models.each do |file|
        m = File.read(file).match(/validates_uniqueness_of[\s\(]+:(\w+\b)/mi)
        column = m[1]
        table = file.match(/\/(\w+)\.rb/)[1].pluralize
        indexes = ActiveRecord::Base.connection.indexes(table)
        indexes.each do |index_def|
          index_def.unique && columns.include?(column)
        end
      end
    end 
  end
end