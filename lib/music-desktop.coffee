player = require 'mpris-service'

module.exports =
class MusicDesktop
  @COMMANDS = [
    { name: 'next',     function: 'Next' }
    { name: 'pause',    function: 'Pause' }
    { name: 'play',     function: 'Play' }
    { name: 'previous', function: 'Previous' }
    { name: 'toggle',   function: 'PlayPause' }
  ]

  # States methods
  currentState:  (callback) -> callback @player.playbackStatus

  getMetatData: -> @player.metaData
  currentAlbum:  (callback) -> callback @getMetatData['xesam:album']
  currentArtist: (callback) -> callback @getMetatData['xesam:artist']
  currentTrack:  (callback) -> callback @getMetatData['xesam:title']
  currentUrl:    (callback) -> callback @getMetatData['xesam:url']

  # Dynamic commands methods
  constructor: ->
    for command in RdioDesktop.COMMANDS
      do (command) ->
        RdioDesktop::[command.name] = ->
          @player[command.function]()
    @player = Player(
      name: 'spotify',
      identity: 'Spotify Player',
      supportedUriSchemes: ['spotify'],
      supportedMimeTypes: []
    )


  currentlyPlaying: (callback) ->
    this.currentArtist (artist) =>
      this.currentTrack (track) =>
        this.currentUrl (url) =>
          callback
            artist: artist
            track: track
            url: url
