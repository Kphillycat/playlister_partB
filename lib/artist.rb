require 'debugger'

class Artist
	attr_accessor :name, :songs, :genres
	@@count = []

	def initialize
		@name
		@songs = []
		@genres = []
		@@count << self
	end

	def songs_count
		songs.size
	end

	def add_song(new_song)
		if new_song.genre
			new_song.genre.artists << self 
			new_song.genre.artists.uniq!
		end
		songs << new_song
		genres << new_song.genre
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