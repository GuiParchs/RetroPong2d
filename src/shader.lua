local moonshine = require 'moonshine'

local shader = {}

local effects = moonshine.effects
local effect = nil

function shader.load()

    effect = moonshine(effects.filmgrain)
        .chain(effects.chromasep)
        .chain(effects.glow)
        .chain(effects.vignette)
        .chain(moonshine.effects.scanlines)
        .chain(effects.crt)

    effect.parameters = {
            filmgrain = {opacity = 0.8, size = 0.75},
            chromasep = {radius = 2.5},
            glow = {strength = 1},
            vignette = {radius = 0.85, opacity = 0.18},
            scanlines = {frequency = GAME_HEIGHT, opacity = 0.5}
        }
end

function shader.resize(w, h)
    if not effect then return end

    effect.resize(w, h)
end

function shader.get()
    return effect
end

return shader