if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__
  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require_relative 'lib/interface'
require_relative 'lib/game'

puts "Привет приговорённые!"

word = File.readlines(File.join(__dir__, "data", "words.txt"), encoding: 'UTF-8', chomp: true).sample

game = Game.new(word)
interface = Interface.new(game)

until game.over?
  interface.print_out
  letter = interface.user_input
  game.play!(letter)
end

interface.print_out
