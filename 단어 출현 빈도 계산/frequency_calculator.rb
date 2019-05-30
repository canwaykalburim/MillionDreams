require_relative "words_from_string.rb"
require_relative "count_frequency.rb"

raw_text = File.open("TEXT.txt", r)

word_list = words_from_string(raw_text)
counts    = count_frequency(word_list)
sorted    = counts.sort_by {|word, count| count}
top_five  = sorted.last(5)

top_five.each do |word, count|
  puts "#{word} : #{count}"
end