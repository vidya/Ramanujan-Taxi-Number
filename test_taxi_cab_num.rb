require 'pry'

require 'minitest/autorun'
require './taxi_cab_num'

class TestTaxiCabNum < MiniTest::Unit::TestCase
  def setup
    test_nums = [1, 12, 27, 35, 224, 36, 1729]

    test_nums.each { |tn| self.class.__send__(:attr_accessor, "tc_num_#{tn}") }

    test_nums.each { |tn| instance_variable_set "@tc_num_#{tn}", TaxiCabNum.new(tn) }
  end

  def test_if_max_lesser_cube_works_for_12
    tc_num_12.cubes.max.must_equal 8
  end

  def test_if_max_lesser_cube_works_for_27
    tc_num_27.cubes.max.must_equal 27
  end

  def test_that_max_lesser_cube_returns_array_of_cubes
    tc_num_12.cubes.must_equal [0, 1, 8]
  end

  def test_that_for_27_complement_of_19_is_a_cube
    tc_num_27.is_complement_a_cube.call(19).must_equal true
  end

  def test_that_1_is_a_sum_of_cubes
    result = tc_num_1.is_a_sum_of_cubes.call

    assert result, 'error: says - 1 is not a sum of cubes'
  end

  def test_that_224_is_a_sum_of_cubes
    result = tc_num_224.is_a_sum_of_cubes.call

    assert result, 'error: says - 224 is not a sum of cubes'
  end

  def test_that_for_35_cube_pairs_is_right
    tc_num_35.cube_pairs.call.must_equal [[8, 27]]
  end

  def test_that_for_1729_there_are_two_cube_pairs
    cube_pairs = tc_num_1729.cube_pairs.call

    cube_pairs.must_equal [[1, 1728], [729, 1000]]
  end
end

