require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/exhibit'
require './lib/patron'
require './lib/museum'

class MuseumTest < Minitest::Test
  def setup
    @gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    @dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    @imax = Exhibit.new({name: "IMAX",cost: 15})
    @bob = Patron.new("Bob", 0)
    @sally = Patron.new("Sally", 20)
    @johnny = Patron.new("Johnny", 5)
    @dmns = Museum.new("Denver Museum of Nature and Science")
  end

  def test_it_exists
    assert_instance_of Museum, @dmns

    assert_equal "Denver Museum of Nature and Science", @dmns.name
    assert_equal [], @dmns.exhibits
  end

  def test_it_can_add_exhibits
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    assert_equal [@gems_and_minerals,@dead_sea_scrolls,@imax], @dmns.exhibits
  end

  def test_it_can_recommend_exhibits
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    @sally.add_interest("IMAX")

    assert_equal [@gems_and_minerals, @dead_sea_scrolls], @dmns.recommend_exhibits(@bob)
    assert_equal [@imax], @dmns.recommend_exhibits(@sally)
  end

  def test_it_can_admit_patrons
    assert_equal [], @dmns.patrons

    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    @sally.add_interest("IMAX")
    @johnny.add_interest("Dead Sea Scrolls")
    @dmns.admit(@bob)

    @dmns.admit(@sally)

    @dmns.admit(@johnny)
    assert_equal [@bob,@sally,@johnny], @dmns.patrons
  end

  def test_patron_by_exhibit_interest
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    @bob.add_interest("Gems and Minerals")
    @bob.add_interest("Dead Sea Scrolls")
    @sally.add_interest("Dead Sea Scrolls")
    @johnny.add_interest("Dead Sea Scrolls")
    @dmns.admit(@bob)

    @dmns.admit(@sally)

    @dmns.admit(@johnny)

    expected = {
      @gems_and_minerals => [@bob],
      @dead_sea_scrolls => [@bob,@sally,@johnny],
      @imax => []
    }
    assert_equal expected, @dmns.patrons_by_exhibit_interest
  end
end