# The following pig latin exercise was solved using two methods, one
# that pig latin-izes an individual word and another that takes a
# sentence and splits it up by spaces, then calls the word method on
# each word.  Handles external word punctuation but the variable
# names could use a little reworking.

def pig_latin_word(english)
  vowels = ["a", "e", "i", "o", "u"]
 
  if vowels.include?(english[0].downcase)
    english
  else
    vowel_index = english.index(/[aeiouy]/)
    front_half = english.slice!(vowel_index..-1)
    back_half = english
    punct = front_half.slice!(/\W$/)
    punct = "" if punct == nil
    pig_word = front_half + back_half + "ay" + punct
  end
end
 
def pig_latin_sentence(english_sentence)
  pig_array = []
  english_array = english_sentence.split(" ")
  english_array.each do |word|
    pig_array << pig_latin_word(word)
  end
  pig_array.join(" ")
end
 
p pig_latin_sentence('Hello, my name is, Charlie!')