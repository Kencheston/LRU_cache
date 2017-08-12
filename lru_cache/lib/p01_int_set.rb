class MaxIntSet

  attr_reader :store
  def initialize(max)
    @max = max
    @store = Array.new (max) {false}
    @store[-1] = true
  end

  def insert(num)
    raise "Out of bounds" if num > @max || num < 0
    @store[num - 1] = true
  end

  def remove(num)
    @store[num - 1] = false
  end

  def include?(num)
    @store[num - 1] == true
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet


  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] = num
  end

  def remove(num)
    self[num] = []
  end

  def include?(num)
    return true unless self[num].is_a?Array
    false
  end

  private

  def [](num)
    @store[num % @store.length]
  end

  def []=(num, num_copy)
    @store[num % @store.length] = num_copy
  end

  def num_buckets
    @store.length
  end
end


class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    #if last bucket is full then increase array by n (max) buckets
    @count = 0
  end

  def insert(num)
    if count == @store.size
      self.resize!
    else
      if self[num - 1].is_a?Array
        self[num - 1] = num
        @count += 1
      end
    end
  end

  def remove(num)
    self[num - 1] = []
  end

  def include?(num)
    return true unless @store[num - 1].is_a?Array
  end

  def resize!
    #when we make twice as big of an array....
    #we need to rearrange our numbers of the array.. SO
    #create a new empty array twice the length
    #then shuffle in the old array based on the new modulo
    new_array = (Array.new(2 * @store.size))
    # [[], [], [], [], [], []]
    mod = new_array.length

    @store.each { |bucket| new_array[bucket % mod] }
    @count += 1
    @store = new_array
  end

  private

  def [](num)
    @store[num % @store.length]
  end

  def []=(num, num_copy)
    @store[num % @store.length] = num_copy
  end

  def num_buckets
    @store.length
  end

end
