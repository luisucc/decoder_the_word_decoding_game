class Decoder

  ##
  ## @brief      { Receives an uncoded word and returns the same word. }
  ##
  ## @param      word  { String }
  ##
  ## @return     { String }
  ##
  def uncoded(word)
    word
  end


  ##
  ## @brief      { Receives a upside down word  and returns the same word
  ##             decoded. }
  ##
  ## @param      word  { String }
  ##
  ## @return     { String }
  ##
  def upside_down(word)
    word.reverse
  end


  ##
  ## @brief      { Receives a word with numbers instead of vowels and returns
  ##             the same word decoded. }
  ##
  ## @param      word  { String }
  ##
  ## @return     { String }
  ##
  def change_numbers_by_vowels(word)
    word.gsub(/[13406]/, '1'=>'i', '3'=>'e', '4'=>'a', '0'=>'o', '6'=>'u')
  end


  ##
  ## @brief      { Receives a word with a section of n-letter of the end at the
  ##             beginning of the word and returns the same word decoded }
  ##
  ## @param      word     { String }
  ## @param      nletter  { Integer }
  ##
  ## @return     { String }
  ##
  def end_at_the_beginning(word, nletter = 3)
    word_to_chars = word.chars
    word_length   = word.length

    # Separate the word in two sections
    beginning_section = word_to_chars[word_length-nletter..word_length]
    ending_section = word_to_chars[0..word_length-(nletter+1)]

    # Order the word
    decoded_word = beginning_section << ending_section
    decoded_word.join
  end


  ##
  ## @brief      { Receives a word with asterisks instead of vowels and returns
  ##             the same word decoded. }
  ##
  ## @param      word  { String }
  ##
  ## @return     { String }
  ##
  def change_asterisks_by_vowels(word)
    number_of_asterisks = word.count('*')
    vowels = 'aeiou'.chars

    posibilities = vowels.repeated_permutation(number_of_asterisks).to_a

    posibilities.each do |posibility|
      i = 0
      numbers = ("1".."#{number_of_asterisks}").to_a.map!{|x| x.to_i}.join
      word_with_numbers = word.chars.map! {|letter|  letter == "*" ? i = 1 + i : letter }.join
      decoded_word = word_with_numbers.tr("#{numbers}", "#{posibility.join}")
      response = interactor.call_to_the_url(url_to_send_answer, decoded_word)
      if response == "OK! - You have succesfully completed this challenge, please ask for another word to see the next challenge"
        break
      end
    end
  end


  ##
  ## @brief      Ignore the downcase letther and change numbers by vowels;
  ##             returns the same word decoded.
  ##
  ## @param      word  { String }
  ##
  ## @return     { String }
  ##
  def ignore_downcase_and_change_numbers_by_vowels(word)
    ignore_downcase = word.gsub(/[#{alphabet}]/, '')
    change_numbers_by_vowels(ignore_downcase).downcase
  end

  def finished?(word)
    "YOU HAVE FINISHED!" if word == "YOU HAVE FINISHED!"
  end

  def alphabet
    ('a'..'z').to_a
  end

end
