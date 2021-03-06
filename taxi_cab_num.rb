# taxi-cab-numbers
# =========
#
# from
#    - http://www.primepuzzles.net/puzzles/puzz_090.htm
#    - http://en.wikipedia.org/wiki/Taxicab_number
#    - http://euler.free.fr/taxicab.htm
#
# given a positive integer, find all the ways it can be written as the sum of two different cubes.

require 'pry'

class TaxiCabNum
  attr_accessor :test_num, :cubes, :cubes_hash

  #--- lambda attr_accessors
  attr_accessor :lesser_cubes, :is_complement_a_cube, :is_a_sum_of_cubes, :cube_pairs

  def initialize(num)
    @test_num = num

    @cubes = []

    @cubes_hash = {}

    define_steps

    @lesser_cubes.call
  end

  def define_steps
    @lesser_cubes = -> do
      valid_base_nums   = (0..test_num).select { |n| (n * n * n) <= test_num }

      @cubes_hash       = valid_base_nums.inject({}) { |h, n| h[n] = n * n * n; h }

      @cubes            = @cubes_hash.values
    end

    @is_complement_a_cube = ->(num) { cubes.include? (test_num - num) }

    @is_a_sum_of_cubes = -> do cubes.any? { |num| is_complement_a_cube.call num } end

    @cube_pairs = -> do
      list = []

      cubes_hash.each_pair do |num, num_cube|
        complement = test_num - num_cube

        if cubes_hash.values.include?(complement)
          list << [num_cube, complement]  if num_cube < complement
        end
      end

      list
    end

  end
end

=begin

--- strategy
  - for each step that solves a part of the problem we will define a lambda
  - for each such lambda we will define an attr_accessor
  - we can unit test each of the lambdas using the corresponding attr_accessor
=end
