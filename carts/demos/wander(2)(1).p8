pico-8 cartridge // http://www.pico-8.com
version 19
__lua__
-- wander demo
-- by zep

x=24 y=24 -- position (in tiles)
dx=0 dy=0 -- velocity
f=0       -- frame number
d=1       -- direction (-1, 1)

function _draw()
	cls(1)
	
	-- move camera to current room
	room_x = flr(x/16)
	room_y = flr(y/16)
	camera(room_x*128,room_y*128)
	
	-- draw the whole map (128⁙32)
	map()
	
	-- draw the player
	spr(1+f,      -- frame index
	 x*8-4,y*8-4, -- x,y (pixels)
	 1,1,d==-1    -- w,h, flip
	)
end

function _update()
	
	ac=0.1 -- acceleration
	
	if (btn(⬅️)) dx-= ac d=-1
	if (btn(➡️)) dx+= ac d= 1
	if (btn(⬆️)) dy-= ac
	if (btn(⬇️)) dy+= ac
	
	-- move (add velocity)
	x+=dx y+=dy
	
	-- friction (lower for more)
	dx *=.7
	dy *=.7
	
	-- advance animation according
	-- to speed (or reset when
	-- standing almost still)
	spd=sqrt(dx*dx+dy*dy)
	f= (f+spd*2) % 4 -- 4 frames
	if (spd < 0.05) f=0
	
	-- collect apple
	if (mget(x,y)==10) then
		mset(x,y,14)
		sfx(0)
	end
	
end

__gfx__
0000000000000000000000000007000700070007000000000000000000000000000000000000000033333b333333333333333333339933333333333333333333
000000000007000700070007000777770007777700000000000000000000000000000000000000003333b33333b3333333333333339a39933333333333b33333
007007000007777700077777700717717007177100000000000000000000000000000000000000003388b8833b333b333333b33333377a93333333333b333b33
000770007007177170071771700777e7700777e70000000000000000000000000000000000000000388888783333b3333b33b33339a77333333333333333b333
00077000700777e7700777e70776686007766860000000000000000000000000000000000000000038888888333b333b33b3b3b3399ba93333333333333b333b
0070070007766860077668600777777007777770000000000000000000000000000000000000000038e8888833b333b333b333b3333b99333333333333b333b3
00000000077777700777777070d0070670d070600000000000000000000000000000000000000000338e888333333b3333333333333b33333333333333333b33
00000000171d7160171d171601111100011111000000000000000000000000000000000000000000311888333333333333333333331b33333333333333333333
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000077007707700077007700770077000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000e7007e0e77007e00e7007e00e70077e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000e7007e00e7007e00e7007e00e7007e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000077777700777777007777770077777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000071771700717717007177170071771700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007777000077770000777700007777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007777000077777000777700077777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000070007000070000000700070000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333b33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
3333333333333333333333333b333b33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
3333333333333333333333333333b333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
333333333333333333333333333b333b333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333b333b3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333b33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
3333333333333333333333333333333333333333333333333333333333b333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333b333333333333333333333333333333333333b333b333333333333333333333333333333333333333333333333333333333333333333
33333333333333333b33b333333333333333333333333333333333333333b3333333333333333333333333333333333333333333333333333333333333333333
333333333333333333b3b3b333333333333333333333333333333333333b333b3333333333333333333333333333333333333333333333333333333333333333
333333333333333333b333b33333333333333333333333333333333333b333b33333333333333333333333333333333333333333333333333333333333333333
3333333333333333333333333333333333333333333333333333333333333b333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333b333333333333333333333
33333333333333333333333333333333333333333333b333333333333333333333333333333333333333333333333333333333333b333b333333333333333333
33333333333333333333333333333333333333333b33b333333333333333333333333333333333333333333333333333333333333333b3333333333333333333
333333333333333333333333333333333333333333b3b3b333333333333333333333333333333333333333333333333333333333333b333b3333333333333333
333333333333333333333333333333333333333333b333b33333333333333333333333333333333333333333333333333333333333b333b33333333333333333
3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333b333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
333333333333333333333333333333333333333333333333333333333333333333b3333333333333333333333333333333333333333333333333333333333333
3333333333333333333333333333b3333333b3333333333333333333333333333b333b3333333333333333333333333333333333333333333333333333333333
3333333333333333333333333b33b3333b33b3333333333333333333333333333333b33333333333333333333333333333333333333333333333333333333333
33333333333333333333333333b3b3b333b3b3b3333333333333333333333333333b333b33333333333333333333333333333333333333333333333333333333
33333333333333333333333333b333b333b333b333333333333333333333333333b333b333333333333333333333333333333333333333333333333333333333
333333333333333333333333333333333333333333333333333333333333333333333b3333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333339933333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333339a39933333333333333333
3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377a933333333333333333
3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333339a773333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333399ba9333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333b99333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333b33333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333331b33333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
333333333333333333b3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333b333b3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333b33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
3333333333333333333b333b33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
333333333333333333b333b333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
333333333333333333333b3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333373337333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333377777333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333373371771333333333333333333333333333333333333333333333333333333333333
333333333333333333333333333333333333333333333333333333333333733777e7333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333337766863333333333333333333333333333333333333333333333333333333333333
333333333333333333333333333333333333333333333333333333333333377777733333333333333333333333333333333333333333b3333333333333333333
333333333333333333333333333333333333333333333333333333333333171d71633333333333333333333333333333333333333b33b3333333333333333333
3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333b3b3b33333333333333333
3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333b333b33333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333399333333333333
3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333339a399333333333
333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377a9333333333
333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333339a7733333333333
3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333399ba93333333333
3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333b993333333333
3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333b333333333333
3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333331b333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333339933333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333339a39933333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
3333333333377a933333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
3333333339a773333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333399ba9333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333b99333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333b33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333331b33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333b3333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333b333b3333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333b33333333333
3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333b333b33333333
333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333b333b333333333
333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333b3333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
3333333333333333333333333333333333333333333333333333b3333333333333333333333333333333333333333333333333333333b3333333333333333333
3333333333333333333333333333333333333333333333333b33b3333333333333333333333333333333333333333333333333333b33b3333333333333333333
33333333333333333333333333333333333333333333333333b3b3b333333333333333333333333333333333333333333333333333b3b3b33333333333333333
33333333333333333333333333333333333333333333333333b333b333333333333333333333333333333333333333333333333333b333b33333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333b3333333333333333333333333333333b333333333333333333333333333333333333333333333
3333333333333333333333333333b33333333333333333333b333b333333333333333333333333333b333b3333333333333333333333b333333333333333b333
3333333333333333333333333b33b33333333333333333333333b3333333333333333333333333333333b33333333333333333333b33b333333333333b33b333
33333333333333333333333333b3b3b33333333333333333333b333b333333333333333333333333333b333b333333333333333333b3b3b33333333333b3b3b3
33333333333333333333333333b333b3333333333333333333b333b333333333333333333333333333b333b3333333333333333333b333b33333333333b333b3
33333333333333333333333333333333333333333333333333333b3333333333333333333333333333333b333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
333333333333333333333333333333333333333333b33333333333333333333333333333333333333333333333333333333333333333333333b3333333333333
33333333333333333333333333333333333333333b333b3333333333333333333333333333333333333333333333333333333333333333333b333b3333333333
33333333333333333333333333333333333333333333b33333333333333333333333333333333333333333333333333333333333333333333333b33333333333
3333333333333333333333333333333333333333333b333b3333333333333333333333333333333333333333333333333333333333333333333b333b33333333
333333333333333333333333333333333333333333b333b3333333333333333333333333333333333333333333333333333333333333333333b333b333333333
333333333333333333333333333333333333333333333b33333333333333333333333333333333333333333333333333333333333333333333333b3333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333

__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000e0e0e0f0e0e0e0e0e0e0e0e0e0e0e0e0d0b0e0e0e0e0e0e0e0e0e0e0e0e0e0e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000e0e0c0e0e0e0e0f0e0e0e0e0e0e0e0e0c0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000e0e0e0e0e0c0e0e0e0e0e0e0e0f0e0e0e0e0e0c0e0e0e0a0e0e0b0e0e0e0e0e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000e0e0e0c0c0e0e0e0b0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0c0c0e0e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0f0e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000e0e0e0e0e0e0e0e0e0e0e0e0e0d0e0e0c0e0e0e0e0e0e0e0e0e0e0a0e0f0e0e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000e0e0f0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0f0b0e0e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0f0e0e0e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000e0e0e0e0e0e0e0e0e0e0e0e0e0c0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0c0e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000e0e0e0e0e0e0e0e0e0e0e0e0e0e0d0e0e0e0e0e0e0e0e0e0e0a0e0e0e0e0e0e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0f0e0e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000e0d0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000e0e0e0e0e0e0e0e0e0e0e0e0e0e0b0e0e0c0e0e0e0f0e0e0e0e0c0e0e0e0e0e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000e0e0e0e0e0e0c0e0e0e0e0e0e0c0e0e0e0e0e0f0f0e0e0e0e0e0e0e0e0e0e0f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000e0e0e0c0e0e0f0e0e0e0f0e0e0c0e0c0e0e0e0c0e0e0e0e0e0e0e0e0d0e0f0e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000e0e0e0e0e0b0e0e0e0e0e0e0e0e0b0e0e0d0e0e0f0e0e0e0e0e0e0c0e0e0e0e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100001b5701f5701d5701f570225602755024542275422e532335223a52230502355023c5022b5022e5022e502335022e502305023a7023a7023a7023a7023a7023a7023a7023a7003a7003a7003b7003b700
011000001805000000000001a0501c050000001f050000002105023050210501f0501c050000001f0501c050170500000000000180501c050000001f0500000022050210501f0501e0501f0501f0421f02200000
010600000a3750f37513375183750f3750f47511475164751b47516475164751b4651d4651b4551b4551d445224451d4351d43524425274252441524415294052b40524405244052740529405274052440527405
__music__
03 01424344

