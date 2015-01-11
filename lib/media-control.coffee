Player = require 'mpris-service'

class MediaControl
  @COMMANDS = [
    { name: 'next',     function: 'Next' }
    { name: 'pause',    function: 'Pause' }
    { name: 'play',     function: 'Play' }
    { name: 'previous', function: 'Previous' }
    { name: 'toggle',   function: 'PlayPause' }
  ]

  MediaControl::player = {}

  # currentAlbum:  (callback) -> callback @getMetatData['xesam:album']
  # currentArtist: (callback) -> callback @getMetatData['xesam:artist']
  # currentTrack:  (callback) -> callback @getMetatData['xesam:title']
  # currentUrl:    (callback) -> callback @getMetatData['xesam:url']

  # Dynamic commands methods
  constructor: (configs) ->
    if configs?
      @configs = configs
      atom.config.onDidChange 'media.player', ({newValue, oldValue}) =>
        @player = Player @configs[newValue]
    @createCommands()

  createCommands: ->
    for command in @COMMANDS
      do (command) ->
        MediaControl::[command.name] = ->
          @player[command.function]()

module.exports = MediaControl
