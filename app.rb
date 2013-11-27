require './lib/artist'
require './lib/genre'
require './lib/song'

def debrackafy(word)
	word.gsub!(/\[/,"").gsub!(/\]/, "")
end

all_the_songs = Dir.entries("data").select {|f| !File.directory? f}
# artist_name_regex = /(.*(?=\-))/
artist_name_regex = /((.*\w*) (?=\-))/
song_name_regex = /(?<=\-).*(?=\[)/
genre_name_regex = /\[.*\]/

artist_name = artist_name_regex.match(all_the_songs[0]).to_s.strip
song_name = song_name_regex.match(all_the_songs[0]).to_s.strip
genre_name = genre_name_regex.match(all_the_songs[0]).to_s.strip

artist1 = Artist.new
song1 = Song.new
genre1 = Genre.new

artist1.name = artist_name
song1.name = song_name
genre1.name = debrackafy(genre_name)

artist_name_array = []
song_name_array = []
genre_name_array = []

all_the_songs.each do |song|
	artist_name_array << artist_name_regex.match(song).to_s.strip
	song_name_array << song_name_regex.match(song).to_s.strip
	genre_name_array << genre_name_regex.match(song).to_s.strip
end

ap artist_name_array
ap song_name_array
ap genre_name_array
ap all_the_songs