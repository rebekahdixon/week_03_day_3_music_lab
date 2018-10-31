require('pry')
require_relative('../models/album')
require_relative('../models/artist')

mummy = Artist.new({'name' => 'mummy'})

mummy.save()

halloween = Album.new({'title' => 'halloween', 'genre' => 'spooky', 'artist_id' => mummy.id})
christmas = Album.new({'title' => 'christmas', 'genre' => 'festive', 'artist_id' => mummy.id})
# binding.pry


halloween.save()
christmas.save()

Album.all_albums()
Artist.all_artists()
mummy.albums_artist_is_in()
# binding.pry
# nil
