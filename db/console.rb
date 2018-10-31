require('pry')
require_relative('../models/album')
require_relative('../models/artist')

Album.delete_all()
Artist.delete_all()

mummy = Artist.new({'name' => 'mummy'})

mummy.save()

halloween = Album.new({'title' => 'halloween', 'genre' => 'spooky', 'artist_id' => mummy.id})
christmas = Album.new({'title' => 'christmas', 'genre' => 'festive', 'artist_id' => mummy.id})
# binding.pry


halloween.save()
christmas.save()

halloween.title = 'scary_songs'
halloween.update()

mummy.name = 'vampire'
mummy.update()

Album.all_albums()
Artist.all_artists()
mummy.albums_artist_is_in()
# binding.pry
# nil
