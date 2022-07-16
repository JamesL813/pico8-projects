pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
--initialization and update

function _init()
	state="game"
	t=0
	
	--cursor
	cur={x=64,y=8}
	
	--background color
	bgc=1
	rectfill(0,0,127,127,bgc)
	
	--sand color
	s_c=15
	
	--list of sand particles
	sand={}
	
end

function _update60()
	t+=1
	
	--move cursor
	if btn(⬅️) then cur.x-=1 end
	if btn(➡️) then cur.x+=1 end
	if btn(⬆️) then cur.y-=1 end
	if btn(⬇️) then cur.y+=1 end
	
	--change sand color
	if btnp(❎) then 
		s_c-=1 
		if s_c%16==bgc then s_c-=1 end
	end
	
	if btnp(🅾️) then 
		s_c+=1 
		if s_c%16==bgc then s_c+=1 end
	end
	
	for s in all(sand) do
		update_sand(s)
	end
end

function _draw() 
	
	--add particles
	local x=cur.x-2+rnd(4)
	local y=cur.y+3
	
	
	rectfill(cur.x-2,cur.y-2,
	 cur.x+3,cur.y+3,bgc)
	rectfill(cur.x-1,cur.y-1,
		cur.x+2,cur.y+2,7)
	rectfill(cur.x,cur.y,
		cur.x+1,cur.y+1,s_c)
	
	pset(cur.x-1,cur.y-1,bgc)
	pset(cur.x+2,cur.y-1,bgc)
	pset(cur.x-1,cur.y+2,bgc)
	pset(cur.x+2,cur.y+2,bgc)
	
	
	add(sand,{x=x+1,y=y,
	 t=0,col=s_c})
		
	pset(x+1,y,s_c)
	
	--iterate through queue
	--and make swaps
	for c in all(chng) do
		
		c1=pget(c.x1,c.y1)
		c2=pget(c.x2,c.y2)
		
		pset(c.x1,c.y1,c2)
		pset(c.x2,c.y2,c1)
	
		del(chng,c)
	end
	
	--test code
	--prints # of frames passed 
	--rectfill(0,0,32,8,bgc)
	--print(s_c,0,0,7)
	
end
-->8
--sand

function update_sand(s)
	local x=s.x
	local y=s.y
	
	if y>=127 or x<=1 or x>=127 then
	 del(sand,s) return end
	
	--sand is below
	if pget(x,y+1)!=bgc then
		if pget(x-1,y+1)==bgc then
			pset(s.x,s.y,pget(x-1,y+1))
			s.y+=1
			s.x-=1
		elseif pget(x+1,y+1)==bgc then
			pset(s.x,s.y,pget(x+1,y+1))
			s.y+=1
			s.x+=1
		else
			if pget(x,y-1)!=bgc and
			 pget(x+1,y)!=bgc and 
			 pget(x-1,y)!=bgc then
				s.t+=1
				if s.t==10 then
					del(sand,s) end
			else
				s.t=0
			end
		end
	
	--no particles below
	else
		pset(s.x,s.y,pget(x,y+1))
		s.y+=1
		
	end
	
	pset(s.x,s.y,s.col)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000007aa7000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000007aa7000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
5555555555555555555555555555555555555555555555555555555555555f5f55ff555555555555555555555555555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555555555555555f555f55555555555555555555555555555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555555555555555f5f5f5f555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555fffff55f555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555f5555f55555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555555ff55f555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555f5555f55555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555f5f5f5f5555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555f5f5ffff555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555ff555555555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555fff55f5f555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555fffffff5555555555555555555555555555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555555555555555555555f555555555555555555555555555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555555555555555555f555555555555555555555555555555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555555555555555f5f555f555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555f555f55f555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555f55555ff555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555f5fff555555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555f5555f55555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555ff55f55f555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555ff555ff5555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555f5f55555555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555ffff5f55555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555f5555f55555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555f5f5ff55555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555ff55ff55555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555f5f5f555555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555f555ff55555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555f5ffffff555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555f5555555555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555fffff55f555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555f55555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555555f55ff555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555555555555555555f555555555555555555555555555555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555555555555555f555555555555555555555555555555555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555555555555555555555f555555555555555555555555555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555555555555555f555555555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555f5555555555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555555f5555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555f55555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555555555f5555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555fff55f555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555f5555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555f5555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555f55555555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555f5555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555555555555555555f555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555f55555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555555555f5555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555f55f55555555555555555555555555555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555555555555555555f5f5555555555555555555555555555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555555555555555555555f555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555f55555555555555555555555555555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555555555555555f555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555555f5555555555555555555555555555555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555555555555555555f555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555f555f5555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555f5555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555ff5555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555555555555555f555555555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555f555555f555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555f5f5555f5555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555f5f55555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555555555555555555f555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555ff5555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555555f5555555555555555555555555555555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555555555555555555f555555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555555f5555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555555f5fff55f555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555ffff55555555555555555555555555555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555555555555555ffffff5555555555555555555555555555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555555555555f5ffffffff555555555555555555555555555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555555555555ffffffffffff5555555555555555555555555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555555555555ffffffffffff5555555555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555555555ffffffffffffff555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555ffffffffffffffff55555555555555555555555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555555555ffffffffffffffffff5555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555ffffffffffffffffffffff55555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555ffffffffffffffffffffff55555555555555555555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555555ffffffffffffffffffffffff5555555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555555555fffffffffffffffffffffffffff55555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555ffffffffffffffffffffffffffff55555555555555555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555ffffffffffffffffffffffffffffff5555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555fffffffffffffffffffffffffffffffff555555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555f5ffffffffffffffffffffffffffffffffff55555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555ffffffffffffffffffffffffffffffffffffff555555555555555555555555555555555555555555555
555555555555555555555555555555555555555555555ffffffffffffffffffffffffffffffffffffff555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555f55fffffffffffffffffffffffffffffffffffffffff5555555555555555555555555555555555555555555
55555555555555555555555555555555555555555f5ffffffffffffffffffffffffffffffffffffffffff5f55555555555555555555555555555555555555555
55555555555555555555555555555555555555555ffffffffffffffffffffffffffffffffffffffffffffff55555555555555555555555555555555555555555
55555555555555555555555555555555555555555ffffffffffffffffffffffffffffffffffffffffffffff55555555555555555555555555555555555555555
555555555555555555555555555555555555555fffffffffffffffffffffffffffffffffffffffffffffffff5555555555555555555555555555555555555555
555555555555555555555555555555555555555ffffffffffffffffffffffffffffffffffffffffffffffffff555555555555555555555555555555555555555
55555555555555555555555555555555555555ffffffffffffffffffffffffffffffffffffffffffffffffffff55555555555555555555555555555555555555
555555555555555555555555555555555555fffffffffffffffffffffffffffffffffffffffffffffffffffffff5555555555555555555555555555555555555
555555555555555555555555555555555555ffffffffffffffffffffffffffffffffffffffffffffffffffffffff555555555555555555555555555555555555
55555555555555555555555555555555555ffffffffffffffffffffffffffffffffffffffffffffffffffffffffff55555555555555555555555555555555555
555555555555555555555555555555555fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff5555555555555555555555555555555555
55555555555555555555555555555555fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff555555555555555555555555555555555
5555555555555555555555555555555fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff55555555555555555555555555555555
555555555555555555555555555555fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff5555555555555555555555555555555
55555555555555555555555555555ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff55555555555555555555555555555
5555555555555555555555555555ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff5555555555555555555555555555
555555555555555555555555555ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff555555555555555555555555555
55555555555555555555555555ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff55555555555555555555555555
5555555555555555555555555ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff5555555555555555555555555
555555555555555555555555ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff555555555555555555555555
55555555555555555555555ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff55555555555555555555555
555555555555555555555fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff5555555555555555555555
5555555555555555555ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff555555555555555555555

__map__
0000000000000000000000000000000500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0005000000000000000000000000000500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0006000000000000000000000000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000060000000000000000000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000600000000120000000700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
