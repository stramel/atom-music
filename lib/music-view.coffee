{View} = require 'atom'
MusicDesktop = require './music-desktop'

module.exports =
  class MusicView extends View

    @content: ->
      @div class: 'music', =>
        @div outlet: 'container', class: 'music-container inline-block', =>
          @span outlet: 'soundBars', class: 'music-sound-bars', =>
            @span class: 'music-sound-bar'
            @span class: 'music-sound-bar'
            @span class: 'music-sound-bar'
            @span class: 'music-sound-bar'
            @span class: 'music-sound-bar'

          @a outlet: 'currentlyPlaying', href: 'javascript:',''

    initialize: ->
      @currentTrack = {}
      @currentState = null
      @initiated = false
      @musicDesktop = new MusicDesktop

      this.addCommands()

      # Make sure the view gets added last
      if atom.workspaceView.statusBar
        this.attach()
      else
        this.subscribe atom.packages.once 'activated', =>
          setTimeout this.attach, 1

  destroy: ->
    this.detach()

  # Commands
  addCommands: ->
    # Defaults
    for command in musicDesktop.COMMANDS
      do (command) =>
        atom.workspaceView.command "music:#{command.name}", '.editor', => @musicDesktop[command.name]()

  # Attach the view to the farthest right of the status bar
  attach: =>
    atom.workspaceView.statusBar.appendRight(this)

    # Toggle equalizer on config change
    showEqualizerKey = "Music.#{MusicView.CONFIGS.showEqualizer.key}"
    this.subscribe atom.config.observe showEqualizerKey, callNow: true, =>
      if atom.config.get(showEqualizerKey)
        @soundBars.removeAttr('data-hidden')
      else
        @soundBars.attr('data-hidden', true)

  afterAttach: =>
    setInterval =>
      @rdioDesktop.currentState (state) =>
        if state isnt @currentState
          @currentState = state
          @soundBars.attr('data-state', state)

        # Music is closed
        if state is undefined
          if @initiated
            @initiated = false
            @currentTrack = {}
            @container.removeAttr('data-initiated')
          return

        # Music is paused, but we know about the current track
        return if state is 'paused' and @initiated

        # Get current track data
        @rdioDesktop.currentlyPlaying (data) =>
          return unless data.artist and data.track
          return if data.artist is @currentTrack.artist and data.track is @currentTrack.track
          @currentlyPlaying.text "#{data.artist} - #{data.track}"
          @currentlyPlaying.attr 'href', "#{data.url}"
          @currentTrack = data

          # Display container when hidden
          return if @initiated
          @initiated = true
          @container.attr('data-initiated', true)
    , 1500
