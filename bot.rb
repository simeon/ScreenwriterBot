require 'rubygems'
require 'twitter'

client = Twitter::REST::Client.new do |config|
	config.consumer_key			= "CONSUMER KEY HERE"
	config.consumer_secret		= "CONSUMER KEY SECRET HERE"
	config.access_token			= "ACCESS TOKEN HERE"
	config.access_token_secret	= "ACCESS TOKEN SECRET HERE"
end

def pick_random_line(filename)
  chosen_line = nil
  File.foreach(filename).each_with_index do |line, number|
    chosen_line = line if rand < 1.0/(number+1)
  end
  return chosen_line
end

def correct_article(params_word)
    %w(a e i o u).include?(params_word[0].downcase) ? "an #{params_word}" : "a #{params_word}"
end

genre = pick_random_line("genre.txt")
genreADJ = pick_random_line("genreADJ.txt")
person = pick_random_line("person.txt")
adjective = pick_random_line("adjective.txt")
object = pick_random_line("object.txt")
topic = pick_random_line("topic.txt")
reason = pick_random_line("reason.txt")

rand = rand(1...3)
if (rand == 1)
	sentence = "#{genreADJ.capitalize} #{genre} following #{person}'s #{topic} as #{correct_article(adjective)} #{object}".gsub("\n",'')
else
	sentence = "#{person} plays the role of a #{object} trying #{reason} in this #{genreADJ} #{genre}".gsub("\n",'')
end

puts sentence
client.update(sentence)