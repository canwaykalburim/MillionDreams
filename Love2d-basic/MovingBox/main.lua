function love.load()
  x = 0
  y = 0
end

function love.update(dt)
  if love.keyboard.isDown("right") then
    x = x + 1 
  elseif love.keyboard.isDown("left") then
    x = x - 1
  end

  if love.keyboard.isDown("up") then
    y = y - 1 
  elseif love.keyboard.isDown("down") then
    y = y + 1
  end
end

function love.draw()
  love.graphics.setColor(255, 255, 0)
  love.graphics.rectangle("fill", x, y, 100, 100)
end