class ListOps
  class << self
    def arrays(array)
      count = 0
      array.each { |_| count += 1 }
      count
    end

    def reverser(array)
      new_array = []
      array.each { |item| new_array.unshift(item) }
      new_array
    end

    def concatter(l, r)
      r.each { |item| l << item }
      l
    end

    def mapper(array)
      new_array = []
      array.each { |item| new_array << yield(item) }
      new_array
    end

    def filterer(array, &block)
      new_array = []
      array.each { |item| new_array << item if block.call(item) }
      new_array
    end

    def sum_reducer(array)
      sum = 0
      array.each { |n| sum += n }
      sum
    end

    def factorial_reducer(array)
      factorial = 1
      array.each { |n| factorial *= n }
      factorial
    end
  end
end
