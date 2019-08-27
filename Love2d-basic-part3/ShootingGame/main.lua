love.graphics.setDefaultFilter('nearest', 'nearest')
enemy = {}
enemies_controller = {}
enemies_controller.enemies = {}
enemies_controller.image = love.graphics.newImage('image/enemy_3cm.png')

function checkCollisions(enemies, bullets)
  for i,e in ipairs(enemies) do
    for _,b in pairs(bullets) do
      if b.y <= e.y + e.height and b.x > e.x and b.x < e.x + e.width then
        table.remove(enemies, i)
      end
    end
  end
end

function love.load()
  local music = love.audio.newSource('bgm/startMusic.wav', 'static')
  music:setLooping(true)
  love.audio.play(music)
  game_over = false
  game_win = false
  background_image = love.graphics.newImage('image/background.png')
  player = {}
  player.x = 0
  player.y = 480
  player.bullets = {}
  player.cooldown = 20
  player.speed = 2
  player.image = love.graphics.newImage('image/player_3cm.png')
  player.fire_sound = love.audio.newSource('bgm/LaserGunSoundEffect.wav', 'static')
  player.fire = function()
    if player.cooldown <= 0 then
      love.audio.play(player.fire_sound)
      player.cooldown = 20
      bullet = {}
      bullet.x = player.x + 38.5
      bullet.y = player.y - 5
      table.insert(player.bullets, bullet)
    end
  end

  for i = 0, 5 do
    enemies_controller:spawnEnemy(i * 130, 0)
  end
end

function enemies_controller:spawnEnemy(x, y)
  enemy = {}
  enemy.x = x
  enemy.y = y
  enemy.width = 60
  enemy.height = 10
  enemy.bullets = {}
  enemy.cooldown = 20
  enemy.speed = 1
  table.insert(self.enemies, enemy)
end

function enemy:fire()
  if self.cooldown <= 0 then
    self.cooldown = 20
    bullet = {}
    bullet.x = self.x + 10
    bullet.y = self.y
    table.insert(self.bullets, bullet)
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

  if #enemies_controller.enemies == 0 then
    game_win = true
  end

  for _,e in pairs(enemies_controller.enemies) do
    if e.y >= love.graphics.getHeight() then
      game_over = true
    end
    e.y = e.y + enemy.speed
  end

  for i,b in ipairs(player.bullets) do
    if b.y < -10 then
      table.remove(player.bullets, i)
    end
    b.y = b.y - 10
  end

  checkCollisions(enemies_controller.enemies, player.bullets)
end

function love.draw()
  -- background
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(background_image)

  if game_over then
    love.graphics.print("Game Over!")
    return
  elseif game_win then
    love.graphics.print("You Won!")
    return
  end

  -- Player
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(player.image, player.x, player.y)
  
  -- enemy
  love.graphics.setColor(255, 255, 255)
  for _,e in pairs(enemies_controller.enemies) do
    love.graphics.draw(enemies_controller.image, e.x, e.y)
  end

  -- Bullet
  love.graphics.setColor(255, 0, 0)
  for _,b in pairs(player.bullets) do
    love.graphics.rectangle("fill", b.x, b.y, 5, 10)
  end
end