class AssetBundler < ToolSearcher
  
  def self.requirement
    has?("Rails built-in asset cache") do
      Matcher.all_files_include_text?(Sentinel.method_call(:javascript_include_tag, :with => :cache), :in => :layouts) &&
      Matcher.all_files_include_text?(Sentinel.method_call(:stylesheet_link_tag, :with => :cache), :in => :layouts)
    end
    
    has?("Bundle_fu") do
      Matcher.all_files_include_text?('bundle do', :in => :layouts)
    end
    
    has?("Asset Packager") do
      Matcher.all_files_include_text?("javascript_include_merged", :in => :layouts) && 
      Matcher.all_files_include_text?("stylesheet_link_merged", :in => :layouts)
    end
  end
end