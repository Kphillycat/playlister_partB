require './lib/artist'
require './lib/genre'
require './lib/song'
require 'debugger'

def debrackafy(word)
	word.gsub!(/\[/,"").gsub!(/\]/, "")
end

def grab_data_from_dir(path)
	Dir.entries(path).select {|f| !File.directory? f}
end

def create_regex_format_array(regex_format, values_array)
	values_array.collect do |value|
		regex_format.match(value).to_s.strip
	end
end

def create_objects_array(object_type, number_of_objects)
	object_array = []
	number_of_objects.times do
		object_array << object_type.new
	end
	object_array
end

def set_name_for_object_array(object_array, name_array)
	object_array.each_with_index do |object, index|
		object.name = name_array[index]
	end
end

def add_genres_to_songs(song_objects_array, genre_objects_array)
	song_objects_array.each_with_index do |song, index|
		song.genre = genre_objects_array[index]
	end
end

def add_song_to_artist(artist_object_array, song_objects_array)
	artist_object_array.each_with_index do |artist, index| 
		artist.add_song(song_objects_array[index])
	end

end

artist_name_regex = /((.*\w*) (?=\-))/
song_name_regex = /(?<=\-).*(?=\[)/
genre_name_regex = /\[.*\]/

all_the_songs = grab_data_from_dir("data")

artist_name_array = create_regex_format_array(artist_name_regex, all_the_songs)
song_name_array = create_regex_format_array(song_name_regex, all_the_songs)
genre_name_array = create_regex_format_array(genre_name_regex, all_the_songs)

genre_name_array.collect do |genre|
	debrackafy(genre)
end
#remove the brackets from genre captured by the genre_array_regex

#Step 1: Create new objects for each song, artist and genre
artist_objects_array = create_objects_array(Artist, artist_name_array.length)

song_objects_array = create_objects_array(Song, song_name_array.length)

genre_objects_array = create_objects_array(Genre, genre_name_array.length)

#Step 2: Add name to artist, song, genre
artist_objects_array = set_name_for_object_array(artist_objects_array, artist_name_array)
song_objects_array = set_name_for_object_array(song_objects_array, song_name_array)
genre_objects_array = set_name_for_object_array(genre_objects_array, genre_name_array)

#Step 3: Add genres to songs
song_objects_array = add_genres_to_songs(song_objects_array, genre_objects_array)

#Step 4: Add song to artist

artist_objects_array = add_song_to_artist(artist_objects_array, song_objects_array)




# ap artist_name_array
# ap song_name_array
# ap genre_name_array
# ap all_the_songs