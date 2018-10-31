require('pg')
require_relative('./artist')



class Album

  attr_reader :id
  attr_accessor :title, :genre, :artist_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "INSERT INTO albums ( title, genre, artist_id) VALUES ($1, $2, $3) RETURNING id"
    values = [@title, @genre, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def self.all_albums()
    sql = "SELECT * FROM albums"
    results = SqlRunner.run(sql)
    all_albums = results.map { | album | Album.new(album)}
    return all_albums
  end

  def all_albums_by_artist()
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@artist_id]
    results = SqlRunner.run(sql, values)
    all_albums_by_artist = results.map { |album| Album.new(album)}
    return all_albums_by_artist
  end

  def update()
    sql = "UPDATE albums SET (title, genre, artist_id) = ($1, $2, $3)WHERE id = $4"
    values = [@title, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM album WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    album_hash = results.first
    album = Artist.new(album_hash)
    return album
  end

end
