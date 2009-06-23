require File.dirname(__FILE__) + '/spec_helper'

describe Sentinel, "when dealing with the interpolated variable regex" do
  before do
    @regex = Sentinel::INTERPOLATED_VAR
  end
  it "should match if a var is interpolated a string" do
    test_string = '"asdf #{var} asd"'
    test_string.should match(@regex)
  end
  it "should not match a regular string" do
    '"hello this s"'.should_not match(@regex)
  end
  it "should not match an concatenated variable" do
    '"hello" + var'.should_not match(@regex)
  end
  
  it "should not match a string with a number sign in it" do
    '"hello#"'.should_not match(@regex)
  end
end

describe Sentinel, "when dealing with the concatenated variable regex" do
  before do
    @regex = Sentinel::CONCATENATED_VAR
  end
  it "should return true if a var is appended to a string" do
    test_string = 'params + "name LIKE"'
    test_string.should match(@regex)
  end
  it "should match if a hash value is appened to a string" do
    'params[:query] + "name LIKE"'.should match(@regex)
  end
  it "should return true if a var is appended to a string" do
    test_string = '"hello" + variable'
    test_string.should match(@regex)
  end
  it "should not match a regular string" do
    '"hello this s"'.should_not match(@regex)
  end
  it "should not match an interpolated variable" do
    '"hello #{var}"'.should_not match(@regex)
  end
end

describe Sentinel, "when dealing with sql_injection" do
  before do
    @regex = Sentinel.sql_injection
  end
  it "should match an interpolated var in a conditions array" do
    test_find = '@tasks = Task.find(:all, :conditions => ["name LIKE ?", "%#{params[:query]}%"])'
    test_find.should match(@regex)
  end
  
  it "should match an interpolated var in a conditions string" do
    test_find = '@tasks = Task.find(:all, :conditions => "name LIKE %#{params[:query]}%")'
    test_find.should match(@regex)
  end
  
  it "should match an appended concatenated var" do
    test_find = '@tasks = Task.find(:all, :conditions => "name LIKE" + params[:query])'
    test_find.should match(@regex)
  end
  
  it "should match a prepended concatenated var" do
    test_find = '@tasks = Task.find(:all, :conditions => params + "name LIKE")'
    test_find.should match(@regex)
  end
  
  it "should match a var" do
    test_find = '@tasks = Task.find(:all, :conditions => params)'
    test_find.should match(@regex)
  end
  
  it "should match a hash var" do
    test_find = '@tasks = Task.find(:all, :conditions => params[:value])'
    test_find.should match(@regex)
  end
end

describe Sentinel, "when dealing with method call regex" do
  
  it {'javascript :param, :cache => true'.should match(Sentinel.method_call(:javascript, :with => :cache))}
  it {'javascript :param, :cache => true'.should match(Sentinel.method_call(:javascript))}
  it {'javascript :param'.should match(Sentinel.method_call(:javascript))}
  it {'javascript'.should match(Sentinel.method_call(:javascript))}
  it {'javascript :cache => true'.should match(Sentinel.method_call(:javascript))}
  
  it {'javascriptt'.should_not match(Sentinel.method_call(:javascript))}
  it {'javascrip'.should_not match(Sentinel.method_call(:javascript))}
  it {'javascript'.should_not match(Sentinel.method_call(:javascript, :with => :cache))}
  
end