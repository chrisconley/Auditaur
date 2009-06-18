class AssetBundler < ToolSearcher
  
  def self.requirement
    has?("Rails built-in asset cache") do
      Matchers.all_files_include_method?(:javascript_include_tag, :with => :cache, :in => :layouts) &&
      Matchers.all_files_include_method?(:stylesheet_link_tag, :with => :cache, :in => :layouts)
    end
    
    has?("Bundle_fu") do
      Matchers.all_files_include_text?('bundle do', :in => :layouts)
    end
    
    has?("Asset Packager") do
      Matchers.all_files_include_text?("javascript_include_merged", :in => :layouts) && 
      Matchers.all_files_include_text?("stylesheet_link_merged", :in => :layouts)
    end
  end
end