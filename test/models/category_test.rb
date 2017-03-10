require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: "sports")
  end
  
  test "should create a valid category" do
    assert @category.valid?
  end
  
  test "the name to be present" do
    @category.name = " "
    assert_not @category.valid?
  end

  test "the name to be unique" do
    @category.save
    category2 = Category.new(name: "sports")
    assert_not category2.valid?
  end
  
  test "the name to be not too long" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end
  
  test "the name to be not too short" do
    @category.name = "aa"
    assert_not @category.valid?
  end
  
end

