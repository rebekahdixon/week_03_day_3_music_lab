require('pg')
require_relative('../db/sql_runner')
require_relative('./album')

class Artist

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO artists (name) VALUES ($1) RETURNING id"
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def self.all_artists()
    sql = "SELECT * FROM artists"
    results = SqlRunner.run(sql)
    all_artists = results.map {|artist| Artist.new(artist)}
    return all_artists
  end

  def albums_artist_is_in()
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [@id]
    results = SqlRunner.run(sql,values)
    albums = results.map { |album| Album.new(album)}
    return albums
  end

  def update()
    sql = "UPDATE artists SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    artist_hash = results.first
    artist = Artist.new(artist_hash)
    return artist
  end


end
