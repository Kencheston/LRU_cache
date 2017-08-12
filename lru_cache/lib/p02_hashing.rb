require "byebug"
class Fixnum
end

#
class Array
  def hash
    if self.empty?
      return nil.hash
    end
    value = 1
    id = self.each_with_index { |el, idx| value += (el.hash) * idx }
    value
  end
end

class String
  def hash
    value = 0
    self.chars.each_with_index do |letter, idx|
      value -= (letter.ord * (idx+1))
    end
    value
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    value = 1
    self.each do
      |key, val| value += key.hash * val.hash
    end
    value
  end
end
