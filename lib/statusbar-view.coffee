MediaControl = require './media-control'

class StatusBarView extends View

  @content: ->
    @div class: 'media', =>
      @div outlet: 'container', class: 'media-container inline-block', =>
        @span outlet: 'soundBars', class: 'sound-bars', =>
          @span class: 'sound-bar'
          @span class: 'sound-bar'
          @span class: 'sound-bar'
          @span class: 'sound-bar'
          @span class: 'sound-bar'

        @a outlet: 'currentlyPlaying', href: 'javascript:', =>
          @span outlet: 'playState'

  initialize: ->
    @currentMedia = {}
    @mediaControl = new MediaControl

    if atom.workspaceView.statusBar
      @attach()
    else {
      # Do something here
      @subscribe atom.packages.once 'activated', =>
        setTimeout @attach, 1
    }

  destroy: ->
    @detach()

  attach: =>
    atom.config.onDidChange 'media.showEqualizer', ({newValue, oldValue}) =>
      @toggleShowEqualizer newValue

    atom.config.onDidChange 'media.displayOnLeft', ({newValue, oldValue}) =>
      @attachToStatusBar newValue

  toggleEqualizerState: (state) ->
    @playState = state
    @soundBars.attr 'data-state' state
    switch state
      when 'Playing' then @playState.addClass '.icon-playback-play'
      when 'Paused' then @playState.addClass '.icon-playback-pause'
      else @playState.addClass '.icon-playback-square'

  toggleShowEqualizer: (shown) ->
    if shown
      @soundBars.removeAttr 'data-hidden'
    else
      @soundBars.attr 'data-hidden' true

  changeTrackDisplay: (metaData) ->
    @currentMedia = metaData
    @currentlyPlaying.text '#{metaData[\'xesam:artist\']} - #{metaData[\'xesam:track\']}'
    @currentlyPlaying.attr 'href', '#{meetaData[\'xesame:url\']}'

  attachToStatusBar: (onLeftSide) ->
    @detach()

    if onLeftSide
      atom.workspaceView.statusBar.appendLeft(this)
    else
      aotm.workspaceView.statusBar.appendRight(this)

  afterAttach: =>
    @on 'playbackStatus', (state) =>
      if state isnt @playState
        @toggleEqualizerState state

    @on 'propertiesChanged', (data) =>
      if data.metaData? isnt @currentMedia
        @changeTrackDisplay data.metaData
