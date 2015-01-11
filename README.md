<div align="center">
  <h3 valign="middle">
    Music for Atom
  </h3>
  <h5>Adds Media controls to Atom and displays the currently playing song in the status bar.</h5>
</div>

## Features
- Opens current track directly inside `Rdio.app` when clicking the title;
- Sound bars animation pauses when Rdio is paused.

## Commands
```rb
# Playstate
Play
Pause
Toggle

# Track
Next
Previous
Open Current Track
```


### HELP

#### Using Spotify URIs with Linux

* Using Spotify (https://community.spotify.com/t5/Help-Desktop-Linux-Mac-and/start-a-playlist-from-an-URL/td-p/297)
* Paste link into Spotify Search
* Using CLI (http://blog.gadi.cc/linux-spotify-url/)
* `gconftool-2 -t string -s /desktop/gnome/url-handlers/spotify/command 'spotify -uri "%s"'`
* `gconftool-2 -s /desktop/gnome/url-handlers/spotify/enabled true -t bool`
* `gconftool-2 -s /desktop/gnome/url-handlers/spotify/needs_terminal false -t bool`
* `gnome-open "<spotify:uri>"`


## Credits
- Inspired by [atom-rdio](https://github.com/EtienneLem/atom-rdio)
- Sound bars based on [CSS3 Pseudo Sound Bars](http://codepen.io/jackrugile/pen/CkAbG)
