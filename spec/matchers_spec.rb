require File.dirname(__FILE__) + '/spec_helper'

describe Matchers, "when asking constant_defined?" do
  it "should return false if constant is undefined" do
    Matchers.constant_defined?("ThisConstantIsUndefined").should be_false
  end
  
  it "should return true if constant exists" do
    DEF = 'def'
    Matchers.constant_defined?("DEF").should be_true
  end
end

describe Matchers, "when asking if text exists in a file" do
  before do
    File.stub!(:read).and_return('Test file contents')
  end
  it "should return true if the text exists" do
    Matchers.file_includes_text?('test', :in => '/bogus/file.rb').should be_true
  end
  
  it "should return false if the text does not exist" do
    Matchers.file_includes_text?('/bogus', :in => '/bogus/file.rb').should be_false
  end
end

describe Matchers, "when asking if text exists in multiple files" do
  before do
    FileManager.stub!(:send).and_return(['file1', 'file2'])
  end
  it "should return true if the text exists in all files" do
    File.should_receive(:read).with('file1').and_return('Test file contents')
    File.should_receive(:read).with('file2').and_return('Test file different contents')
    Matchers.all_files_include_text?('Test file', :in => :bogus_files).should be_true
  end
  
  it "should return false if the text does not exist in any file" do
    File.should_receive(:read).with('file1').and_return('Test file contents')
    Matchers.all_files_include_text?('different', :in => :bogus_files).should be_false
  end
end

describe Matchers, "when asking if a method exists in a file without parentheses" do
  before do
    File.stub!(:read).and_return('awesome_method "awesome", :awesome_option => :awesome')
  end
  
  it "should return true if no option is given" do
    Matchers.file_includes_method?(:awesome_method, :in => '/bogus/file.rb').should be_true
  end
  
  it "should return true if the method exists with an option specified" do
    Matchers.file_includes_method?(:awesome_method, :with => :awesome_option, :in => '/bogus/file.rb').should be_true
  end
  
  it "should return false if the method exists, but without the option" do
    Matchers.file_includes_method?(:awesome_method, :with => :bad_option, :in => '/bogus/file.rb').should be_false
  end
  
  it "should return false if the method does not exist" do
    Matchers.file_includes_method?(:bad_method, :with => :awesome_option, :in => '/bogus/file.rb').should be_false
  end
end

describe Matchers, "when asking if a method exists in a file with parentheses" do
  before do
    File.stub!(:read).and_return('awesome_method("awesome", :awesome_option => :awesome)')
  end
  
  it "should return true if no option is given" do
    Matchers.file_includes_method?(:awesome_method, :in => '/bogus/file.rb').should be_true
  end
  
  it "should return true if the method exists with an option specified" do
    Matchers.file_includes_method?(:awesome_method, :with => :awesome_option, :in => '/bogus/file.rb').should be_true
  end
  
  it "should return false if the method exists, but without the option" do
    Matchers.file_includes_method?(:awesome_method, :with => :bad_option, :in => '/bogus/file.rb').should be_false
  end
  
  it "should return false if the method does not exist" do
    Matchers.file_includes_method?(:bad_method, :with => :awesome_option, :in => '/bogus/file.rb').should be_false
  end
end

describe Matchers, "when asking if a method exists in multiple files" do
  before do
    FileManager.stub!(:send).and_return(['file1', 'file2'])
  end
  it "should return true if the text exists in all files" do
    File.should_receive(:read).with('file1').and_return('awesome_method("awesome", :awesome_option => :awesome)')
    File.should_receive(:read).with('file2').and_return('awesome_method("awesome", :awesome_option => :awesome)')
    Matchers.all_files_include_method?(:awesome_method, :with => :awesome_option, :in => :bogus_files).should be_true
  end
  
  it "should return false if the text does not exist in any file" do
    File.should_receive(:read).with('file1').and_return('bad_method("awesome", :awesome_option => :awesome)')
    Matchers.all_files_include_method?(:awesome_method, :with => :awesome_option, :in => :bogus_files).should be_false
  end
end