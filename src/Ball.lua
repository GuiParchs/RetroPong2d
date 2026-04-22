local Class = require 'lib.class'

local Ball = Class{}

Ball.size = 4

function Ball:init(x, y)
    self.x = x
    self.y = y

    self.dx = 0
    self.dy = 0
end

function Ball:serve(player)
    self.dy = math.random(-60, 60)

    if player == 1 then
        self.dx = math.random(120, 180)
    else
        self.dx = -math.random(120, 180)
    end
    
end

-- Returns 1 if player 1 scores, 2 if player 2 scores, nil otherwise
function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    -- Collision with top
    if self.y <= 0 then
        self.y = 0
        self:_hitWall()

    -- Collision with bottom
    elseif self.y >= VIRTUAL_HEIGHT - Ball.size then
        self.y = VIRTUAL_HEIGHT - Ball.size
        self:_hitWall()
    end

    -- Collision with left and right walls (goals)
    if self.x < 0 then
        self:_hitGoal()
        return 2

    elseif self.x >= VIRTUAL_WIDTH then
        self:_hitGoal()
        return 1
    end

    return nil
end

function Ball:collides(paddle)
    -- Axis Align Bounding Box (AABB)

    -- Horizontal check
    if self.x > paddle.x + paddle.width then return false end
    if self.x + Ball.size < paddle.x then return false end

    -- Vertical check
    if self.y > paddle.y + paddle.height then return false end
    if self.y + Ball.size < paddle.y then return false end

    -- Collided!
    self.dx = -self.dx * 1.02
    self.dy = math.random(-150, 150)
    --play sound
    return true
end

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - Ball.size / 2
    self.y = VIRTUAL_HEIGHT / 2 - Ball.size / 2
    self.dx = 0
    self.dy = 0
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, Ball.size, Ball.size)
end

function Ball:_hitWall()
    self.dy = -self.dy
    -- play sound effect
end

function Ball:_hitGoal()
    -- play sound effect
end

return Ball