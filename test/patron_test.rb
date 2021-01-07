require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/exhibit'
require './lib/patron'

class PatronTest < Minitest::Test
  def setup
    @g_m = Exhibit.new({name: "Gems and Minerals", cost: 0})
    @patron_1 = Patron.new("Bob", 20)
  end

  def test_it_exists
    assert_instance_of Patron, @patron_1

    assert_equal "Bob", @patron_1.name
    assert_equal 20, @patron_1.spending_money
    assert_equal [], @patron_1.interests
  end

  def test_it_can_add_intrests
    @patron_1.add_interest("Dead Sea Scrolls")
    @patron_1.add_interest("Gems and Minerals")
    assert_equal ["Dead Sea Scrolls", "Gems and Minerals"], @patron_1.interests
  end
end