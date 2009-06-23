require File.dirname(__FILE__) + '/spec_helper'

describe Matcher, "when asking constant_defined?" do
  it "should return false if constant is undefined" do
    Matcher.constant_defined?("ThisConstantIsUndefined").should be_false
  end
  
  it "should return true if constant exists" do
    DEF = 'def'
    Matcher.constant_defined?("DEF").should be_true
  end
end

describe Matcher, "when asking if text exists in a file" do
  before do
    File.stub!(:read).and_return('Test file contents')
  end
  it "should return true if the text exists" do
    Matcher.file_includes_text?('test', :in => '/bogus/file.rb').should be_true
  end
  
  it "should return false if the text does not exist" do
    Matcher.file_includes_text?('/bogus', :in => '/bogus/file.rb').should be_false
  end
end

describe Matcher, "when asking if text exists in multiple files" do
  before do
    FileManager.stub!(:send).and_return(['file1', 'file2'])
  end
  it "should return true if the text exists in all files" do
    File.should_receive(:read).with('file1').and_return('Test file contents')
    File.should_receive(:read).with('file2').and_return('Test file different contents')
    Matcher.all_files_include_text?('Test file', :in => :bogus_files).should be_true
  end
  
  it "should return false if the text does not exist in any file" do
    File.should_receive(:read).with('file1').and_return('Test file contents')
    Matcher.all_files_include_text?('different', :in => :bogus_files).should be_false
  end
end
