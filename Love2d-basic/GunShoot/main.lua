function love.load()
  player = {}
  player.x = 0
  player.y = 530
  player.bullets = {}
  player.cooldown = 10
  player.speed = 5
  player.fire = function()
    if player.cooldown <= 0 then
      player.cooldown = 10
      bullet = {}
      bullet.x = player.x + 10
      bullet.y = player.y
      table.insert(player.bullets, bullet)
    end
  end
end

function love.update(dt)
  player.cooldown = player.cooldown - 1
  if love.keyboard.isDown("right") then
    player.x = player.x + player.speed
  elseif love.keyboard.isDown("left") then
    player.x = player.x - player.speed
  end

  if love.keyboard.isDown("space") then
    player.fire()
  end

  for i,b in pairs(player.bullets) do
    if b.y < -10 then
      table.remove(player.bullets, i)
    end
    b.y = b.y - 10
  end
end

function love.draw()
  love.graphics.setColor(255, 255, 0)
  love.graphics.rectangle("fill", player.x, player.y, 30, 50)
  
  love.graphics.setColor(255, 0, 0)
  for _,b in pairs(player.bullets) do
    love.graphics.rectangle("fill", b.x, b.y, 10, 10)
  end
end