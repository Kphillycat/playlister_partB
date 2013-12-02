require 'debugger'

class Artist
	attr_accessor :songs, :genres
	@@count = []

	def initialize
		@name
		@songs = []
		@genres = []
		@@count << self
	end

	#add name= to check not to create new object for same artist

	def name=(name)
		@name = name 
	end

	def name
		@name
	end

	def songs_count
		songs.size
	end

	def add_song(new_song)
		if new_song.genre
			new_song.genre.artists << self 
			genres << new_song.genre
			new_song.genre.artists.uniq!
		end
		songs << new_song
		
	end

	def self.reset_artists
		@@count.clear
	end

	def self.count
		@@count.size
	end

	def self.all
		@@count
	end
end