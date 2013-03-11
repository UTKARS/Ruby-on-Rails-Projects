require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
   #test "the truth" do
    # assert true
   #end
test "should not save post without title" do
  micropost = Micropost.new
  assert !micropost.save, "Saved the post without a title"
end
end
