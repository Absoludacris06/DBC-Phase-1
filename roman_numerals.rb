def to_roman(num)
  unless num.integer? && num >= 1 && num <= 9999
    raise ArgumentError.new("Only integers between 1 & 9999 allowed")
  end
 
  num_index = num
  value = [100, 10, 1]
  letter = [["M", "D", "C"], ["C", "L", "X"], ["X", "V", "I"]]
 
  rn = "M" * (num_index / 1000)
  num_index %= 1000
 
  value.length.times do |i|
    places = num_index / value[i]
    case places
      when 4
        rn = rn + letter[i][2] + letter[i][1]
      when 9
        rn = rn + letter[i][2] + letter[i][0]
      else
        rn = rn + letter[i][1] * (places / 5) + letter[i][2] * (places % 5)
    end
    num_index %= value[i]
  end
 
  rn
end
 
# Drive code... this should print out trues.
 
puts to_roman(1) == "I"
puts to_roman(3) == "III"
puts to_roman(6) == "VI"
 
puts "input | expected | actual"
puts "------|----------|-------"
puts "4     | IV       | #{to_roman(4)}"
puts "9     | IX       | #{to_roman(9)}"
puts "14    | XIV      | #{to_roman(14)}"
puts "1453  | MCDLIII  | #{to_roman(1453)}"
puts "1646  | MDCXLVI  | #{to_roman(1646)}"