local push = require 'lib.push'

local Ball = require 'src.Ball'
local Paddle = require 'src.Paddle'

local gameState = require 'src.GameState'

VIRTUAL_WIDTH = 320
VIRTUAL_HEIGHT = 240

WINDOW_WIDTH = 1024
WINDOW_HEIGHT = 768

local BG_COLOR = {40/255, 45/255, 52/255, 1}

local smallFont, mediumFont, largeFont
local paddle1, paddle2
local ball


function love.load()
    love.window.setTitle('PONG')
    
    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true,
        pixelperfect = true
    })

    smallFont = love.graphics.newFont('assets/font.ttf', 8)
    mediumFont = love.graphics.newFont('assets/font.ttf', 16)
    largeFont = love.graphics.newFont('assets/font.ttf', 32)

    local W_OFFSET = 8
    local H_OFFSET = 10

    paddle1 = Paddle(W_OFFSET, H_OFFSET)
    paddle2 = Paddle(VIRTUAL_WIDTH - W_OFFSET - Paddle.width, VIRTUAL_HEIGHT - H_OFFSET - Paddle.height)

    local BALL_OFFSET = Ball.size / 2
    ball = Ball(VIRTUAL_WIDTH / 2 - BALL_OFFSET, VIRTUAL_HEIGHT / 2 - BALL_OFFSET)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()

    elseif key == 'f' then
        push:switchFullscreen()
    end
end

function love.update(dt)
    -- Player 1
    if love.keyboard.isDown('w') then
        paddle1.dy = -Paddle.speed
    elseif love.keyboard.isDown('s') then
        paddle1.dy = Paddle.speed
    else
        paddle1.dy = 0
    end

    -- Player 2
    if love.keyboard.isDown('up') then
        paddle2.dy = -Paddle.speed
    elseif love.keyboard.isDown('down') then
        paddle2.dy = Paddle.speed
    else
        paddle2.dy = 0
    end

    paddle1:update(dt)
    paddle2:update(dt)
end

function love.resize(w, h)
    push:resize(w, h)
end

local function displayScore()
    love.graphics.setFont(largeFont)

    local halfWidth = VIRTUAL_WIDTH / 2
    local h = VIRTUAL_HEIGHT / 5

    -- p1
    love.graphics.printf(
        tostring(gameState.score[1]),
        0,
        h,
        halfWidth,
        'center'
    )

    -- p2
    love.graphics.printf(
        tostring(gameState.score[2]),
        halfWidth,
        h,
        halfWidth,
        'center'
    )
end

local function drawCenterLine(segmentHeight, gap)
    local total = segmentHeight + gap
    local x = math.floor(VIRTUAL_WIDTH / 2 - 1)

    local y = gap

    while y + segmentHeight <= VIRTUAL_HEIGHT - gap do
        love.graphics.rectangle('fill', x, y, 2, segmentHeight)
        y = y + total
    end
end

function love.draw()
    push:start()

    love.graphics.clear(BG_COLOR[1], BG_COLOR[2], BG_COLOR[3], BG_COLOR[4])

    love.graphics.setColor(0.5, 0.5, 0.5, 1)
    drawCenterLine(12, 6)
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setFont(smallFont)
    love.graphics.printf('Welcome to Pong!', 0, 10, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Enter to start', 0, 20, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)

    paddle1:render()
    paddle2:render()

    ball:render()

    displayScore()

    push:finish()
end