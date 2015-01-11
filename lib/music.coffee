MusicView = require './music-view'

module.exports =
  configDefaults: do ->
    configs = {}
    for configName, configData of MusicView.CONFIGS
      configs[configData.key] = configData.default

    configs

  activate: (state) ->
    @musicView = new MusicView(state.musicViewState)

  deactivate: ->
    @musicView.destroy()
