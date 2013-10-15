# Converts given number into words recursively.

NUMBER_TO_WORD = {1000000000 => 'billion',
                  1000000 => 'million',
                  1000 => 'thousand',
                  100 => 'hundred',
                  90 => 'ninety',
                  80 => 'eighty',
                  70 => 'seventy',
                  60 => 'sixty',
                  50 => 'fifty',
                  40 => 'forty',
                  30 => 'thirty',
                  20 => 'twenty',
                  19 => 'nineteen',
                  18 => 'eighteen',
                  17 => 'seventeen',
                  16 => 'sixteen',
                  15 => 'fifteen',
                  14 => 'fourteen',
                  13 => 'thirteen',
                  12 => 'twelve',
                  11 => 'eleven',
                  10 => 'ten',
                  9 => 'nine',
                  8 => 'eight',
                  7 => 'seven',
                  6 => 'six',
                  5 => 'five',
                  4 => 'four',
                  3 => 'three',
                  2 => 'two',
                  1 => 'one'}
 
def in_words(number)
  return 'zero' if number == 0
  NUMBER_TO_WORD.each_pair do |factor, factor_in_english|
    division_results = number.divmod(factor)
    quotient = division_results[0]
    remainder = division_results[1]
    if number >= 100 && quotient > 0
    	if remainder == 0
    		return in_words(quotient) + " " + factor_in_english
    	else
      	return in_words(quotient) + " " + factor_in_english + " " + in_words(remainder)
      end
    elsif quotient == 1
    	if remainder == 0
    		return factor_in_english
    	else
      	return factor_in_english + "-" + in_words(remainder)
      end
    end
  end
end
 
# Driver code
 
p in_words(100) # => 'one hundred'
p in_words(83) # => 'eighty-three'
p in_words(56) # => 'fifty-six'
p in_words(20) # => 'twenty'
p in_words(14) # => 'fourteen'
p in_words(6) # => 'six'
p in_words(1) # => 'one'
p in_words(0) # => 'zero'
 
p in_words(101)  # => 'one hundred one'
p in_words(156)  # => 'one hundred fifty-six'
p in_words(267)  # => 'two hundred sixty-seven'
p in_words(790)  # => 'seven hundred ninety'
p in_words(1000) # => 'one thousand'
 
p in_words(3075)     # => 'three thousand seventy-five'
p in_words(52689)    # => 'fifty-two thousand six hundred eighty-nine'
p in_words(923693)   # => 'nine hundred twenty-three thousand six hundred ninety-three'
p in_words(1000000)  # => 'one million'
 
p in_words(7394857)
p in_words(32749573)
p in_words(204758395)
p in_words(1000000000)
p in_words(3000000000)
p in_words(9999999999)