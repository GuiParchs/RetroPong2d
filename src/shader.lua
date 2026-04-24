local moonshine = require 'moonshine'

local shader = {}

local effects = moonshine.effects

function shader.load()

    local effect = moonshine(effects.crt)
        .chain(effects.chromasep)
        .chain(effects.glow)
        .chain(effects.filmgrain)
        .chain(effects.vignette)
        .chain(moonshine.effects.scanlines)

    effect.parameters = {
            glow = {strength = 1},
            filmgrain = {opacity = 0.8, size = 0.8},
            vignette = {radius = 0.85, opacity = 0.18},
            chromasep = {radius = 2.5},
            scanlines = {frequency = GAME_HEIGHT}
        }
    
    return effect
end

return shader