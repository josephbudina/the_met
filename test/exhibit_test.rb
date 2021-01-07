require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/exhibit'

class ExhibitTest < Minitest::Test
  def setup
    @g_m = Exhibit.new({name: "Gems and Minerals", cost: 0})
  end

  def test_it_exists
    assert_instance_of Exhibit, @g_m

    assert_equal "Gems and Minerals", @g_m.name
    assert_equal 0, @g_m.cost
  end
end