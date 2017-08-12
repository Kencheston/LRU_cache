require_relative 'p02_hashing'
require 'byebug'
#
class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def big_little(key)
    return key if key < 1_000
    big_little(key / 10)
  end

  def remove(val)
    key = big_little(val.hash.abs)
    self[key] = []
  end

  def insert(val)
    key = big_little(val.hash.abs)
    self[key] = val
    @count += 1
    resize! if num_buckets < @count
  end

  def include?(val)
    key = big_little(val.hash.abs)
    return true if self[key] == [val]
    false
  end

  private

  def [](num)
    @store[num % @store.length]
  end

  def []=(num, num_copy)
    @store[num % @store.length] << num_copy
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @count = 0
    @store = Array.new(num_buckets * 2) { Array.new }

    old_store.flatten.each { |key| insert(key) }
  end
end
