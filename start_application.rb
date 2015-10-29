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


