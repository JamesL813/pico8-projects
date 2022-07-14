pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
-- shmup

function _init()
 t=0

 ship = {
  sp=1,
  x=60, y=100,
  dx=2, dy=1,
  h=4,
  p=0,
  t=0,
  imm=false,
  box = {x1=0,y1=0,x2=7,y2=7}}
 bullets = {}
 enemies = {}
 explosions = {}
 stars = {}

 init_stars()

 start()
end

function start()
 _update = update_game
 _draw = draw_game
end

function game_over()
 _update = update_over
 _draw = draw_over
end

function update_over()

end

function draw_over()
 cls()
 print("game over",50,50,4)
end


function update_game()
 t=t+1
 
 update_ship()

 update_stars()

 update_explosions()

 update_enemies()

 update_bullets()
 
end


function draw_game()
 cls()
 draw_stars()

 print(ship.p,9)
 if not ship.imm or t%8 < 4 then
  spr(ship.sp,ship.x,ship.y)
 end

 draw_explosions()

 draw_bullets()

 draw_enemies()

 draw_ship()
end
-->8
-- ship

function init_ship()

end

function update_ship()
 if ship.imm then
  ship.t += 1
  if ship.t >30 then
   ship.imm = false
   ship.t = 0
  end
 end
 
 if(t%6<3) then
  ship.sp=1
 else
  ship.sp=2
 end

	if btn(⬅️) then 
		ship.x-=ship.dx end
 if btn(➡️) then
 	ship.x+=ship.dx end
 if btn(⬆️) then
  ship.y-=ship.dy end
 if btn(⬇️) then
  ship.y+=ship.dy end
 if btnp(❎) then fire() end
end

function draw_ship()
 for i=1,4 do
  if i<=ship.h then
  spr(33,80+6*i,3)
  else
  spr(34,80+6*i,3)
  end
 end
end

function fire()
 local b = {
  sp=3,
  x=ship.x,
  y=ship.y,
  dx=0,
  dy=-3,
  box = {x1=2,y1=0,x2=5,y2=4}
 }
 add(bullets,b)
end

-->8
-- stars


function init_stars()

	for i=1,128 do
  add(stars,{
   x=rnd(128),
   y=rnd(128),
   s=rnd(2)+1
  })
 end

end


function update_stars()

 for st in all(stars) do
  st.y += st.s
  if st.y >= 128 then
   st.y = 0
   st.x=rnd(128)
  end
 end

end

function draw_stars()

 for st in all(stars) do
  pset(st.x,st.y,6)
 end

end
-->8
-- explosions

function init_explosions()

end

function update_explosions()
 for ex in all(explosions) do
  ex.t+=1
  if ex.t == 13 then
   del(explosions, ex)
  end
 end
end

function draw_explosions()
 for ex in all(explosions) do
  circ(ex.x,ex.y,ex.t/2,8+ex.t%3)
 end
end

function explode(x,y)
 add(explosions,{x=x,y=y,t=0})
end
-->8
-- enemies

function init_enemies()

end

function update_enemies()
 if #enemies <= 0 then
  respawn()
 end

 for e in all(enemies) do
  e.m_y += 1.3
  e.x = e.r*sin(e.d*t/50) + e.m_x
  e.y = e.r*cos(t/50) + e.m_y
  if coll(ship,e) and not ship.imm then
    ship.imm = true
    ship.h -= 1
    if ship.h <= 0 then
     game_over()
    end

  end

  if e.y > 150 then
   del(enemies,e)
  end

 end
end

function draw_enemies()
	for e in all(enemies) do
  spr(e.sp,e.x,e.y)
 end
end

function respawn()
 local n = flr(rnd(9))+2
 for i=1,n do
  local d = -1
  if rnd(1)<0.5 then d=1 end
 add(enemies, {
  sp=17,
  m_x=i*16,
  m_y=-20-i*8,
  d=d,
  x=-32,
  y=-32,
  r=12,
  box = {x1=0,y1=0,x2=7,y2=7}
 })
 end
end
-->8
-- bullets


function init_bullets()

end

function update_bullets()
 for b in all(bullets) do
  b.x+=b.dx
  b.y+=b.dy
  if b.x < 0 or b.x > 128 or
   b.y < 0 or b.y > 128 then
   del(bullets,b)
  end
  for e in all(enemies) do
   if coll(b,e) then
    del(enemies,e)
    ship.p += 1
    explode(e.x,e.y)
   end
  end
 end
end

function draw_bullets()
 for b in all(bullets) do
  spr(b.sp,b.x,b.y)
 end
end
-->8
-- collisions

function abs_box(s)
 local box = {}
 box.x1 = s.box.x1 + s.x
 box.y1 = s.box.y1 + s.y
 box.x2 = s.box.x2 + s.x
 box.y2 = s.box.y2 + s.y
 return box
end

function coll(a,b)
 local box_a = abs_box(a)
 local box_b = abs_box(b)

 return box_a.x1 <= box_b.x2
 	and box_a.y1 <= box_b.y2
 	and box_b.x1 <= box_a.x2
 	and box_b.y1 <= box_a.y2
end
__gfx__
00000000008008000080080000099000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000008008000080080000099000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000008888000088880000099000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000088118800881188000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000088cc880088cc88000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000080880800808808000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000a00000000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000a000000a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000bbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000bb70b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000bb77b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000bb77b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000b0bbb0b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000b00b000b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000080800000606000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000888880006666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000088800000666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000008000000060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
66600000000000000000000000000000000000000000000000000060600000000000000000000000000000600000000000000000000000000000000000000000
60600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
60600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
60600000000000000000000000000000000000000000000000000000000000000000000000000000000000080800080800080800080800000000000000000000
66600000000000000000000000000000000000000000000000000000000000000000000000000000000000888880888880888880888880000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000088800088800088800088800060000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000008000008000008060008000000000000000000000
00000000000000006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000
00000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000bbb00000
00000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000bb70b0000
00000000000000000000000000000000000006000000000000000000000000000000060000000000000600000000000000000000000000000000000bb77b0000
00000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000000000bb77b0000
0000000000000000000000000000000000000000000000000600000000000000000060660000000000000000000000000000000000000000000000b0bbb0b000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b00b000b00
00000000000000000000000000000000000000000000000000006006000000000000000000000000000000000000000060000000000000000000000000b00000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060000000000bbb00
00000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000000bb70b0
06000000000000000000000000000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000bb77b0
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000bb77b0
0000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b0bbb0b
0000000000000006000000000000000060000000000000000000000000060000000000000000000000000000000000000000000000000000000000000b00b000
00000000000000600000000000000000000000006000000000000000000000060000000000000000000000000000000000000000000000000000000000000b00
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000600000000000000000000000000000000000000000000000000000000bbb0006000000000000000000000000000000000
000000000000060000000000000000000000000000000000000000000000000000000000000000000000000bb70b000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000bb77b000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000060000990000000000000000000000bb77b000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000099000000006000000000000b0bbb0b00000000000000006000600000000000000
00000000000600000000000000000000000000000000000000000000000000099000000000000000000000b00b000b0000000000000006000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000600000b0000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000bbb0000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000bb70b000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000600bb77b000000000000000000600000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000bb77b000000000000000000000000000000000
00000000000000000000000000000000000000000000000000600000000000000000000000000000000000000b0bbb0b00000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b00b000b0000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b0000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000bbb00000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000006000000bb70b0000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000099000000000bb77b0006000000000000000000060600000000000000000060000
00000000000000000000000000000000000000000000000000000000060000099000000000bb77b0000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000009900000000b0bbb0b000000000000600000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000b00b000b00000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000b00000000000000000000000000000000000060060000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000
0000000000000000000000060000000000000000bbb0000000000000000000000000000000060000000000000000000000000000000006000000000000000600
000000000000000000000000000000000000000bb70b000000000000000000000000000000000000000000000006000000000000000000000000000000000000
000000000000000000000000000000000000000bb77b000000000000000600000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000bb77b000000000000000000000000000000000000000000000000000000000000000000000000060000000000
00000000000000000000000000000000000000b0bbb0b00000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000600000000000000000000000000000000b00b000b0000000000060000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000b0000000000006000000000006000000000000000600000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000bbb0000000000000000000000000000000006000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000bb70b000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000006000000000000000000000bb77b000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000bb77b000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000b0bbb0b00000000000000099000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000b00b000b0000000000000099000000000000000000000000000000000000000060000000000000000000000
000000000000000000000000000006000000000000000b0000000000000000099000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000bbb00000000000000000000000006000000000000000000000000000000600000000000000000000000000600000000000000
00000000006000000000000000bb70b0000000000000000000000000000000000000000000000000000000600000600000000000000000000000000000000000
00000000000000000000000000bb77b0600000000000000000000000000600000000000000000000000000000000000000000000000600000000000000000000
00000000000000000000000000bb77b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000006000000000b0bbb0b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000b00b000b00000000000000000000000000000000000000000000000000000000000000000000000000060000000000000600000
00000000000000000000000000000b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000600000000000000000000000000000600000000000000000000000000000000000000000000000000000
00000000000600000000000000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000600000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000060000000000000000600000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000060000000000000006000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000800800000000000000000000000000000000006000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000800800000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000888800000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000008811880000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000088cc880000000060000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000008088080000000000000000000000000000000000000000000060000000000000000
0000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000
000000000000000000000600000000000000000000000000000000000000000a0000000006000000000000000000000000000000000000000000600000000000
60000000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060000000000000
00000000000000000000000000000000000000000000000000000000000000000000000600000000000000000000000600000000000000000000000000000000
00000000000060000000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000
00000000000000000600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000006000006000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
