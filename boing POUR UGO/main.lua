obj = {}
  obj.x = 50
  obj.y = 50
  obj.vx = 0 
  obj.vy = 0
  obj.speed = 5 
  obj.lastx = 50 
  obj.lasty = 50
  obj.vt = false 
nbj = 2
j = 10
g = 0.5
score = 100

largeur = love.graphics.getWidth()
hauteur = love.graphics.getHeight()

cy = 400
cx = math.random(0,largeur-50)
vcy = 2
cubes = {}

dash = false
dashv = obj.speed * 5
dashd = 10
dashdt = 0 -- durée teste (pas delta time)
dashnb = 1 -- comme nbj : nombre de dash 

function love.draw() 
  if score < 0 then 
    love.graphics.print("GAME OVER !!!",300,hauteur/2)
  else
    for i = 1,#cubes do 
      bloc(cubes[i][1],cubes[i][2],200,10)
    end 
    moi()
    love.graphics.print("score = ".. score,10,10)
  end 
end 



function love.update(dt) 
  while #cubes < 1000 do
    cubes[#cubes+1] = {cx,cy}
    cx = math.random(-50,largeur-50)
    cy = cy-100
  end 
  
  vcy = vcy + 0.01*dt
  
  for i = 1,#cubes do
    cubes[i][2] = cubes[i][2] + vcy 
  end 
  
  obj.lasty = obj.y
  obj.lastx = obj.x
  
  if dash then 
    vy = 0 
    obj.x = obj.x + dashv 
    dashdt = dashdt + 1 
  else 
    obj.y = obj.y + obj.vy 
    if obj.vt then 
    obj.x = obj.x + obj.vx 
    end 
    obj.vy = obj.vy + g
  end 
  
  if dashdt >= dashd then 
    dash = false 
    dashdt = 0 
  end 
  
  if obj.y >= hauteur - 20 then
    obj.y = hauteur - 20 
    obj.vy = -2
    nbj = 0 
    dashnb = 0
    score = score - 4
  elseif obj.y < 0 then 
    score = score + 1
  end 
  
  if obj.x <= 0 then 
    obj.x = 0 
  elseif obj.x >= largeur-10 then
    obj.x = largeur-10
  end 
  keypendent()
end 







function love.keypressed(key)
  if key == "z" and nbj < 2 then
    obj.vy = -j
    nbj = nbj + 1 
  end 
  
  if key == "q" then 
    q = true 
    obj.vt = true 
  end 
  
  if key == "d" then 
    d = true  
    obj.vt = true 
  end 
  
  if key == "e" and dashnb < 1  then
    dash = true 
    dashv = obj.speed * 5
    obj.vx = obj.speed
    dashdt = 0 
    dashnb = dashnb + 1
  end 
  
  if key == "a" and dashnb < 1 then
    dash = true 
    dashv = -obj.speed * 5
    obj.vx = -obj.speed
    dashdt = 0
    dashnb = dashnb + 1
  end 
end


function keypendent()  
  
  if q then 
    obj.vx = -obj.speed  
  end 
  
  if d then 
    obj.vx = obj.speed  
  end 
  
end 

function love.keyreleased(key) 

  if key == "q" then 
    q = false 
    obj.vt = false
  end 
  
  if key == "d" then 
    d = false  
    obj.vt = false 
  end 
end 




























function moi()
  love.graphics.rectangle("fill",obj.x,obj.y,10,20)
end 


function bloc(x,y,tx,ty) 
  love.graphics.rectangle("fill",x,y,tx,ty)
  if obj.y < y+ty and obj.y+20 > y and obj.x < x+tx and obj.x+10 > x then
    if obj.lasty < obj.y then 
      obj.vy = -1
      obj.y = obj.lasty
      obj.x = obj.lastx
      nbj = 0
      dashnb = 0 
    elseif obj.lasty > obj.y then
      obj.vy = 1
      obj.y = obj.lasty+4
      obj.x = obj.lastx
    else
      obj.y = obj.lasty
      obj.x = obj.lastx
      nbj = 0
      dashnb = 0 
    end 

  end
end 
