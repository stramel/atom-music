StatusBarView = require './statusbar-view'
MediaControl = require './media-control'
CSON = require 'cson'

class MediaInitializer

  config:
    showEqualizer:
      title: 'Show Equalizer'
      description: 'Equalizer will show if this preference is enabled. If disabled, you can still see the artist and track'
      type: 'boolean'
      default: true
      order: 1
    displayOnLeft:
      title: 'Show Media Controls on Left Side'
      description: 'Shows the media controls and equalizer on the left side if enabled'
      type: 'boolean'
      default: false
      order: 2
    usePlayer:
      title: 'Media Player to use'
      description: 'Select which media player you would like to control'
      type: 'string'
      default: 'spotify'
      enum: ['spotify']
      order: 3

  activate: ->
    CSON.parseFile 'players.cson', (error, configs) =>
      @mediaControl = new MediaControl(configs)

    @statusBarView = new StatusBarView()

  deactivate: ->
    @statusBstatusBarView.destroy()

module.exports = new MediaInitializer()
