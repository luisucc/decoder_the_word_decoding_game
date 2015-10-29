$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'decoder_the_word_decoding_game'

resource_name = "http://localhost:4567/"
word_path = "word"
answer_path = "answer?answer="

puts "This program is connect to the server: #{resource_name}, the String Encoder Game Server (by Codescrum)."
puts "\n"
puts "You ask the server for a word, thereby:"
url_to_get_word = resource_name+word_path
puts "Use this url = #{url_to_get_word}"
puts "\n"
url_to_send_answer = resource_name+answer_path
puts "You can solve the challenge employed this url = #{url_to_send_answer}<put_the_decoded_word_here>"
puts "\n"

# TODO: The challenge number 6 not working
#
# List to the solved challenges 1, 2, 3, 4, 5, 7
challenges = [1, 2, 3, 4, 5, 7]

interactor = InteractServer.new

decoded_method = Decoder.new

challenges.each do |challenge|
  word = interactor.call_to_the_url(url_to_get_word)
  if decoded_method.finished?(word)
    puts "YOU HAVE FINISHED!"
    break
  end

  puts "The challenge #{challenge} is:"

  case challenge
  when 1
    decoded_word = decoded_method.uncoded(word)
  when 2
    decoded_word = decoded_method.upside_down(word)
  when 3
    decoded_word = decoded_method.change_numbers_by_vowels(word)
  when 4
    # If the section of the end of the word is greater than three, please add
    # the number to the input method
    decoded_word = decoded_method.end_at_the_beginning(word)
  when 5
    # TODO: refactor this.
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
  when 6
    # TODO: not working on server
  when 7
    decoded_word = decoded_method.ignore_downcase_and_change_numbers_by_vowels(word)
  else
    puts "No challenge configured..."
  end

  puts "Get the message the server: #{word} => Response to the server: #{decoded_word}"
  response = interactor.call_to_the_url(url_to_send_answer, decoded_word)
  puts "#{response}"

end
