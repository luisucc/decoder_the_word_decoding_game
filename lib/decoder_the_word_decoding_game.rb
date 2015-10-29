
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "decoder_the_word_decoding_game/version"
require 'pry'
require 'interact_server'
require 'decoder'

module DecoderTheWordDecodingGame
  interactor = InteractServer.new
end


