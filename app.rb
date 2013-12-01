require './lib/artist'
require './lib/genre'
require './lib/song'
require 'debugger'

ARTIST_NAME_REGEX = /((.*\w*) (?=\-))/
SONG_NAME_REGEX = /(?<=\-).*(?=\[)/
GENRE_NAME_REGEX = /\[.*\]/

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

def create_artist_objects_hash(artist_name_array)
	artist_name_hash = {}
	artist_name_array.each do |name|
		artist_name_hash[name.to_sym] = Artist.new
		artist_name_hash[name.to_sym].name = name
	end
	artist_name_hash
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


def add_song_to_artist(artist_object_hash, song_objects_array, all_the_songs)
	song_objects_array.each_with_index do |song, index|
		artist_name = ARTIST_NAME_REGEX.match(all_the_songs[index])		
		artist_object_hash[artist_name[0].strip.to_sym].add_song(song)
	end
	artist_object_hash
end


all_the_songs = grab_data_from_dir("data")

artist_name_array = create_regex_format_array(ARTIST_NAME_REGEX, all_the_songs)
song_name_array = create_regex_format_array(SONG_NAME_REGEX, all_the_songs)
genre_name_array = create_regex_format_array(GENRE_NAME_REGEX, all_the_songs)

genre_name_array.collect do |genre|
	debrackafy(genre)
end
#remove the brackets from genre captured by the genre_array_regex

#Step 1: Create new objects for each song, artist and genre
artist_objects_hash = create_artist_objects_hash( artist_name_array)

song_objects_array = create_objects_array(Song, song_name_array.length)

genre_objects_array = create_objects_array(Genre, genre_name_array.length)


#Step 2: Add name to song and genre.
song_objects_array = set_name_for_object_array(song_objects_array, song_name_array)
genre_objects_array = set_name_for_object_array(genre_objects_array, genre_name_array)

#Step 3: Add genres to songs
song_objects_array = add_genres_to_songs(song_objects_array, genre_objects_array)

#Step 4: Add song to artist

artist_objects_hash = add_song_to_artist(artist_objects_hash, song_objects_array, all_the_songs)

#Parsing and object data structure complete

