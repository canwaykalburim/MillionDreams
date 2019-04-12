triangular_numbers = Enumerator.new do |yielder|
  num = 0
  count = 1
  loop do
    number += count
	count += 1
	yielder.yield number
  end
end

p triangular_numbers.first(5)