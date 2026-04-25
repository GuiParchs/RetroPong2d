local sounds = {}

local FILTER = {type = 'lowpass', highgain = 0.2}

local sources

local function getRandomPitch()
    return 0.985 + (love.math.random() * 0.03) --3% variation
end

function sounds.play(sound)
    local s = sources[sound]
    s:setPitch(EnableCRT and getRandomPitch() or 1)
    
    s:clone():play()
end

function sounds.setFilter(enabled)
    local f = enabled and FILTER or nil

    for _, s in pairs(sources) do
        s:setFilter(f)
    end
end

function sounds.load()
    sources = {
        select = love.audio.newSource('assets/sounds/select.wav', 'static'),
        serve = love.audio.newSource('assets/sounds/serve.wav', 'static'),
        paddleHit = love.audio.newSource('assets/sounds/paddle_hit.wav', 'static'),
        wallHit = love.audio.newSource('assets/sounds/wall_hit.wav', 'static'),
        goal = love.audio.newSource('assets/sounds/goal.wav', 'static')
    }
end

return sounds