pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
--initialization and update
function _init()

	poke(0x5f2d, 1) --activate mouse
	cur={x0=0,x1=0,y=0,t=0}
	mouse=false
	
	init_start()
 gmode="start"
 frame=0
 level=1
 
	timer=0
	max_timer=300
 
 init_parts()
 
 --debug
 debugrect={
 	x1=-1,y1=-1,
 	x2=-1,y2=-1}
 temp1=-1
 temp2=-2
 
 
end

function _update60()

	cur.x1=cur.x0
	cur.x0=stat(32)
	cur.y=stat(33)
	
	if not mouse_inactive() then
		mouse=true
		cur.t=60
	else 
		mouse=false
	end
	
	 
	frame+=1
	if gmode=="start" then
		update_start()
	elseif gmode=="game" then
		update_game()
	elseif gmode=="over" then
		update_over()
	elseif gmode=="win" then
		update_win()
	end
	update_parts()
end

function _draw()
	cls(0)
	draw_parts()
	
 if gmode=="start" then
		draw_start()
	elseif gmode=="game" then
		draw_game()
	elseif gmode=="over" then
		draw_over()
	elseif gmode=="win" then
		draw_win()
	end
	
	
	--debug--
	
	--mouse--
	--print(cur.x0)
	
--	collisions--
--	rectfill(debugrect.x1,
--									 debugrect.y1,
--										debugrect.x2,
--										debugrect.y2,13)
	--print(temp1,2,2,8)
	--print(temp2,10,10,8)
	
	--print(temp1,8)
	

end

--any button pressed?
function any_butt()
	return btnp(⬅️) or btnp(➡️)
	 or btnp(⬆️) or btnp(⬇️)
	 or btnp(❎) or btnp(🅾️)
end

--mouse currently being used?
function mouse_inactive()
	return cur.x0==cur.x1
end
-->8
-- gamestates --

function init_start()
 lives=3
 
 init_blocks(1)
end

function init_game()
	cls(0)
 init_ball()
 init_pad()
 
 offset=0
end

function update_start()
	if btn(❎) then
		gmode="game"
		init_game()
	end
end

function update_game()
 update_pad()
	update_ball()
	update_blocks()
	
	if offset>0 then
		offset-=.2
	end
end

function update_over()
	if btnp(❎) then
		gmode="game"
		init_start()
	end
end

function update_win()
	if btnp(❎) then
		gmode="game"
		init_start()
	end
end



function draw_start()
	
	print("pico-8 dice breaker",
		20,40,7)
	print("press ❎ to start",
		25,60,7)
	print("⬅️ and ➡️ to move paddle",
		15,100,7)
	--print("❎ to use power up",
	--	25,110,7)
end

function draw_game()
 rect(0,0,127,127,7)
 line(0,8,127,8,7)
 
	draw_ball()
	draw_pad()
	draw_blocks()
	
	rc=7
	

	rect(0,0,
		128*(timer/max_timer),7,hl(rc))
	rect(1,1,
		128*(timer/max_timer)+1,8,sh(rc))
	
	rectfill(1,1,
		128*(timer/max_timer),7,rc)
	
	
	for i=0,lives-1 do
		local hc=7
		local lc=hl(hc)
		local dc=sh(hc)
		 
		circfill(5+i*8,3,3,0)
		circfill(5+i*8,3,3,0)
 	print("♥",2+i*8,2,hc)
		line(4+i*8,0,6+i*8,0,7)
		pset(5+i*8,7,0)
		pset(5+i*8,1,7)
		
		
 end
 
 
	cur.t-=1
	
	if mouse or cur.t>1 then
	 pset(cur.x0,cur.y,7)
	 rect(cur.x0-2,cur.y-2,
	 cur.x0+2,cur.y+2,7)
	else 
	end
	
	if offset<1 then
	camera()
	else
	camera(rnd(offset),rnd(offset))
	end

end

function draw_over()
	
	print("game over",
		45,40,7)
	print("press ❎ to try again",
		25,60,7)
end


function draw_win()

	rectfill(25,50,105,75,0)
	rect(25,50,105,75,7)
		
	print("♥♥you win!♥♥",
		30,60,7+((frame/15)%2))
end
-->8
-- ball --

function init_ball()
	ball={
		x=64, y=112, --coords
		r=2, c=6, --radius, color
		cd=3, --hit cooldown
		spd=1,	--velocity magnitude
		max_spd=3, --max speed		
		v={x=rnd(.4)-.2,y=-1}--velocity vector
	}
end

--updates ball
function update_ball()

	if #blocks>0 then
 	ball.x+=ball.v.x*ball.spd
		ball.y+=ball.v.y*ball.spd
	end
	
	if abs(ball.v.y)>2 then
		new_part(ball.x+(rnd(6)-3),
			ball.y+(rnd(6)-3),
			rnd(2)-1,rnd(2)-1,
			5+rnd(20))
	end
	
	--hit cooldown
	if ball.cd>0 then
		ball.cd-=1
	end
	
	--game over state
	if lives==0 then
		gmode="over"
	end
	
	--ball hits block--
	for b in all(blocks) do
	
		--hits bottom
		if ball_box(b.x+1,b.y+b.h/2,
					b.w-2,b.h/2) then
			hit(b)
			if b.roll<0 then
			b.roll=60 end
			ball.v.y=abs(ball.v.y)
			
		--hits top
		end
		if ball_box(b.x+1,b.y,
									b.w-2,b.h/2) then
			hit(b)
			if b.roll<0 then
			b.roll=60 end
			ball.v.y=-abs(ball.v.y)
		
		--hits right
		end
		if ball_box(b.x+b.w/2,
									b.y+1,b.w/2,b.h-2) then
			hit(b)
			if b.roll<0 then
			b.roll=60 end
			ball.v.x=abs(ball.v.x)+.1
	
		--hits left
		end
		if ball_box(b.x,b.y+1,
									b.h/2,b.h-2) then
			hit(b)
			if b.roll<0 then
			b.roll=60 end
			ball.v.x=-abs(ball.v.x)-.1
		end

	end
	--end of blockk loop--
	
	--ball falls below paddle
	if ball.y>127 then
	
		explo(ball.x,ball.y,
				ball.v.y*2,6)
	 sfx(2)
		lives-=1
		init_game()
	end
	
	--ball hits top of paddle
	if ball_box(pad.x,pad.y,
													pad.w,pad.h/2)
	and ball.cd<=0 then
	 pad.c=0
	 ball.cd=8
	 
	 offset=2*abs(ball.v.y)
	 camera(rnd(offset)-(offset/2),
								rnd(offset)-(offset/2))
	 
		ball.v.y=-abs(ball.v.y)
		
		ball.v.x=
			(3*(ball.x-pad.x-3)/pad.w)-1
		
		if ball.spd<ball.max_spd then
			ball.v.y-=.1
		end
		
		explo(ball.x,ball.y,
				ball.v.y*2,6)
		
		sfx(1)
	end
	
	--ball hits left
	if ball_box(pad.x,pad.y+1,
													pad.h/2,pad.h)
	and ball.cd<=0 then
		pad.c=0
	 ball.cd=8
		ball.v.x=-abs(ball.v.x)
		explo(ball.x,ball.y,
				ball.v.y*2,6)
		sfx(1)
	end
	
	--ball hits right
	if ball_box(pad.x+pad.w
					-pad.h/2, pad.y+1,
					pad.h/2, pad.h) 
	and ball.cd<=0 then
	 pad_c=0
		ball.v.x=abs(ball.v.x)
		explo(ball.x,ball.y,
				ball.v.y*2,6)
		sfx(1)
	end
	
	--bell hits right wall
	if ball.x>127 then
		ball.v.x=-abs(ball.v.x)
		explo(ball.x,ball.y,
				ball.v.y*2,6)
	 sfx(0)
	end
	--ball hits left wall
	if ball.x<1 then
		ball.v.x=abs(ball.v.x)
		explo(ball.x,ball.y,
				ball.v.y*2,6)
	 sfx(0)
	end
	
	--ball hits ceiling
	if ball.y<11 then
	 ball.v.y=abs(ball.v.y)
	 explo(ball.x,ball.y,
				ball.v.y*2,6)
	 sfx(0)
	end
end

--draws the ball
function draw_ball()

	if abs(ball.v.y)>2 and ball.y/4%4<2 then
		circfill(ball.x,ball.y,
 									ball.r,ball.c)
 end
 									
 circfill(ball.x,ball.y,
 					ball.r,ball.c)
 					
 line(ball.x-1,ball.y-2,
 					ball.x+1,ball.y-2,
 					hl(ball.c))
 line(ball.x-2,ball.y-1,
 					ball.x-2,ball.y+1,
 					hl(ball.c))
	line(ball.x-1,ball.y+2,
 					ball.x+1,ball.y+2,
 					sh(ball.c))
 line(ball.x+2,ball.y-1,
 					ball.x+2,ball.y+1,
 					sh(ball.c))
 
 
end

--returns true if ball is 
--inside given box
function ball_box(x,y,w,h)

	if ball.y-ball.r>y+h
	or ball.y+ball.r<y
	or ball.x-ball.r>x+w
	or ball.x+ball.r<x then
		return false
	end
	debugrect.x1=x
	debugrect.y1=y
	debugrect.x2=x+w
	debugrect.y2=y+h
	
	return true
end

--normalizes v vector
--obj must contain v={x,y}
function normalize(obj)
	len=
		sqrt(obj.v.x^2 + obj.v.y^2)
	obj.v.x/=len
	obj.v.y/=len
end


-->8
-- paddle --

function init_pad()
	pad={
		w=24,			--width
		h=4,				--height
		c=6,				--color

		x=52, 		--topleft x coor
		y=116,		--topleft y coor

		dx=0,   --speed
		acc=.6, --acceleration
		fric=.6,--friction
	
		max_dx=3--max speed
	}
end

--updates paddle every frame
function update_pad()
	pad.c=6
	
	if mouse and cur.x0 != nil then
		pad.x=cur.x0-(pad.w/2)
	end
	
	--left bound
	if pad.x<1 then
		pad.x=0 end
		
	--right bound
	if pad.x+pad.w>126 then
		pad.x=127-pad.w end
	
	--left input
	if btn(⬅️) and
	not btn(➡️) then
	 pad.dx-=pad.acc
	end
	
	--right input
	if btn(➡️) and
	not btn(⬅️) then
		pad.dx+=pad.acc
	end	
	--no input
	if (not btn(⬅️)
	and not btn(➡️))
	or btn(⬅️) and btn(➡️) then
		if pad.dx>pad.fric then 
			pad.dx-=pad.fric 
		elseif pad.dx<-pad.fric then
			pad.dx+=pad.fric
		else
			pad.dx=0
		end
	end
	
	--limits speed to max
	pad.dx=mid(-pad.max_dx,
												pad.dx,
												pad.max_dx)
	
	pad.x+=pad.dx
	
end

--draws paddle every frame
function draw_pad()
 rect(pad.x,pad.y,
      pad.x+pad.w-1,
      pad.y+pad.h-1,
      hl(pad.c))
 rect(pad.x+1,pad.y+1,
      pad.x+pad.w,pad.y+pad.h,
      sh(pad.c))
 rectfill(pad.x+1,pad.y+1,
      pad.x+pad.w-1,
      pad.y+pad.h-1,
      pad.c)
	pset(pad.x,pad.y,0)
	pset(pad.x+pad.w,pad.y+pad.h,0)
	
 
  
end
-->8
-- particles --

function init_parts()
	parts={}
end

function new_part(x,y,dx,dy,
																		t,c,r)
	
	local pc=c
	if gmode=="win" then
		pc=rnd(7)+8
	else
		ran=rnd(100)
		if ran<33 then pc=hl(pc) end
		if ran>66 then pc=sh(pc) end
		
	end
	
	add(parts,{
		x=x,
		y=y,
		r=r,
		
		c=pc,
		t=t,
		
		dx=dx,
		dy=dy,
		
		fric=0
	
	})
end

function update_parts()
	
	makestars()

	for p in all(parts) do
		
		p.t-=1
		--p.c=rnd(3)+5
		
		p.x+=p.dx
		p.y+=p.dy
		
		--p.dx*=1.1
		--p.dy*=1.1
		
		if p.t<0 or p.x<-10 or p.y<-10
		or p.x>138 or p.y>138 then
			del(parts,p)
		end
		
	end
end

function draw_parts()
	for p in all(parts) do
		
		--pset(p.x,p.y,p.c)
		if gmode=="win" then
			print("★",p.x,p.y,p.c)
		else
			circfill(p.x,p.y,
												p.r,p.c)
		end
		--rectfill(p.x,p.y,
			--								p.x+p.r,p.y+p.r,
			--								p.c)
		
	end
end

function explo(x,y,f,c)

	f=abs(f)
	r=rnd(1)
	if c!=6 then r=rnd(2) end
	

	
	for i=1,rnd(30) do
			new_part(x,y,
												rnd(f)-1,
												rnd(f)-1,
												10+rnd(20),c,r)
		end
		offset=f
end

function makestars()

	f=(frame)/10000
	spd=.1+rnd(3)
	
	dx=sin(f)*spd
	dy=cos(f)*spd
	
	l=1200

	--left
	if rnd(1)<sin(f) then
		new_part(-2,rnd(128),
											dx,dy,l,6,rnd(1))
	end
	
	--right
	if rnd(1)<-sin(f) then
		new_part(130,rnd(128),
											dx,dy,l,6,rnd(1))
	end
	
	--bottom
	if rnd(1)<-cos(f) then
		new_part(rnd(128),130,
											dx,dy,l,6,rnd(1))
	end
	--top
	if rnd(1)<cos(f) then
		new_part(rnd(128),-2,
											dx,dy,l,6,rnd(1))
	end
	
	
end
-->8
-- blocks --

function init_blocks(level)
	blocks={}
	buff={}
	
	for i=0,80 do
		--if rnd(1)>.1 then
		add(blocks,
			{x=(((i%9)*14)-2)+4,
				y=flr(i/9)*12+10,
				w=11,h=9,
				l=3,
				roll=-1,
				n=0})
		--end
	end
	lives=3+level
	
	init_level(level)
end

function init_level(level)
	if level==1 then
		for b in all(blocks) do
			if b.y>60 or b.y<15
			or b.x<15 or b.x>100 then
				del(blocks,b)
			end
			
			if b.y>50 then
				--b.l=1
			end
		end
	end
	
	if level==2 then
		for b in all(blocks) do
			if b.y>70 or b.y<15
			or b.x<15 or b.x>100 then
				del(blocks,b)
			end
			
			if b.y<30 then
				--b.l=1
			end
		end
	end
	
	if level==3 then
		for b in all(blocks) do
			if b.y>70 or b.y<15 then
				del(blocks,b)
			end
			
			if b.y<40 then
				--b.l=1
			end
		end
	end
	
end

function update_blocks()
	check_buff()
	if level>3 then
		gmode="win"
	end

	for b in all(blocks) do
		if b.l<=0 then
			del(blocks,b)
		end
	end
	
	if #blocks<=0 then
		level+=1
		init_blocks(level)
		init_game()
	end
	
end

function draw_blocks()
	for b in all(blocks) do
			
		local c=6
		if b.n>0 and b.roll==0 then
		 c=b.n+7 end
		
		cl=hl(c)
		cd=sh(c)
			
		rectfill(b.x,b.y,
			b.x+b.w-1,b.y+b.h-1,cl)
		
		rectfill(b.x+1,b.y+1,
			b.x+b.w,b.y+b.h,cd)
			
		rectfill(b.x+1,b.y+1,
			b.x+b.w-1,b.y+b.h-1,c)
			
		pset(b.x,b.y,0)
		pset(b.x+b.w,b.y+b.h,0)
 	
 	if b.l<=1 then
 		line(b.x+b.w/2,b.y+b.h,
 			b.x+b.w-1,b.y+3,cd)
 		line(b.x+b.w-3,b.y+b.h/2,
 			b.x+b.w/2,b.y+2,cd)
 		line(b.x+2,b.y,
 			b.x+4,b.y+b.h-3,cd)
 		line(b.x,b.y+b.h/2,
 			b.x+2,b.y+3,cd)
 	end
 	
 	if b.roll>0 then
 		drawnum(b,flr(b.roll%30/5))
 		b.roll-=1
 	else
 		drawnum(b,b.n)
 	end
		
	end
	
end

function drawnum(b,n)

	local c=0

	if n%2==1 then
		rect(b.x+(b.w)/2,
			b.y+(b.h/2),b.x+(b.w)/2+1,
			b.y+(b.h/2)+1,c)
	end

	if n>=2 then
		rect(b.x+1,b.y+1,
			b.x+2,b.y+2,c)
		rect(b.x+b.w-2,b.y+b.h-2,
			b.x+b.w-1,b.y+b.h-1,c)
	end
	
	if n>=4 then
		rect(b.x+b.w-2,b.y+1,
			b.x+b.w-1,b.y+2,c)
		rect(b.x+1,b.y+b.h-2,
			b.x+2,b.y+b.h-1,c)
	end
	
	if n==6 then
		rect(b.x+b.w-2,b.y+(b.h/2),
			b.x+b.w-1,b.y+(b.h/2)+1,c)
		rect(b.x+1,b.y+(b.h/2),
			b.x+2,b.y+(b.h/2)+1,c)
	end
	
end



function hit(b)
	b.l-=1
	sfx(3)
	
	local c=6
	
	if b.roll==0 then
			c=b.n+7 end

	
	if b.roll<0 then
		b.roll=60 
		b.n=flr(rnd(6))+1
		end
	
	if b.l>0 then
		add(buff,b)
	else
		b.roll=-1
	end

	
	explo(ball.x,ball.y,
		ball.v.y*2,c)
	
end

function check_buff()

	if timer<max_timer then
		return else timer=0 end
	
	tab={0,0,0,0,0,0}

	
	
	for b in all(blocks) do
		if b.roll==0 and b.n>0 then
			tab[b.n]+=1
		end
	end
	
	for b in all(buff) do
		if tab[b.n]>=2 then
			b.l=0
			sfx(3)
			explo(b.x+b.w/2,b.y+b.h/2,
				2,b.n+7)
			del(buff,b)
		end
	end
	
	sum=0
	for i=1,6,1 do
		if tab[i]>=2 then
			sum+=tab[i]
		end
	end
	temp1=sum
end

function hl(c)
	if c==0 then return 5 end
	if c==1 then return 12 end
	if c==4 then return 15 end
	if c==6 then return 7 end
	if c==7 then return 7 end
	if c==8 then return 14 end
	if c==9 then return 15 end
	if c==10 then return 7 end
	if c==11 then return 11 end
	if c==12 then return 7 end
	if c==13 then return 6 end
	if c==14 then return 7 end
	return 0
end

function sh(c)
	if c==0 then return 0 end
	if c==1 then return 0 end
	if c==4 then return 2 end
	if c==6 then return 5 end
	if c==7 then return 6 end
	if c==8 then return 2 end
	if c==9 then return 4 end
	if c==10 then return 9 end
	if c==11 then return 3 end
	if c==12 then return 1 end
	if c==13 then return 1 end
	if c==14 then return 8 end
	return 7
end
__gfx__
000000000fffff477777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000f4444206666500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000f4444206666500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000042222266660500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000076660066606500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700076666600606500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000076666666066500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000076066660666500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000076606660666500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000005505505555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70700077707070777007700000777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70700007007070700070000700007000000000000000000000000000000000000000000000000000000000000000000000000000000000007000000000700007
70700007007070770077700000077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70700007007770700000700700007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70777077700700777077000000777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
70000000000000000000000000000000000000000000000000000000000000000077777000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000077777000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000070777000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000007770000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000070000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007000000000000000000000007
70000000000000000000000000000000000000000000000000000000007777777777777000000000000000007777777777777007777777777777000007000007
70000000000000000000000000000000000000000000000000000000007000000000007000000000000000007000000000007007000000000007000000000077
70000000000000000000000000000000000000000000000000000000007000000000007000000000000000007000000000007007000000000007000000000007
70000000000000000000000000000000000000000000000000000000007000000000007000000000000000007000000000007007000000000007000000000007
70000000000000000000000000000000000000000000000000000000007000000000007000000000000000007000000000007007000000000007000000000007
70000000000000000000000000000000000000000000000000000000007000000000007000000000000000007000000000007007000000000007000000000007
70000000000000000000000000000000000000000000000000000000007000000000007000000000000000007000000000007007000000000007000000000007
70000000000000000000000000000000000000000000000000000000007777777777777000000000000000007777777777777007777777777777000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000007777777777777007777777777777000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000007000000000007007000000000007000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000007000000000007007000000000007000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000007000000000007007000000000007000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000007000000000007007000000000007000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000007000000000007007000000000007000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000007000000000007007000000000007000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000007777777777777007777777777777000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000070000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000070000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000070000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000007000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000070007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000707
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000007000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000700000000000000000000000000007000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000070000000000000000000000000000000007777777777777777777777777000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000007000000000000000000000007000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000007077777777777777777777707000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000007000000000000000000000007000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000007777777777777777777777777000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000070000000000000000000000000000000000000000000000000000000000000000000700000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777

__sfx__
0001000016750167501675016750167501575015750157501475014750197501e7502675022700277001a7001d70020700277002d700347003b700297002a7002b7002d7002e7003070032700337003570038700
000100000e0500e0500e0500f050110501305015050190501e050230502c0503005016000110000f0000c0000a000070000500006000040000400004000030000200002000000000000000000000000000000000
00020000390503705034050310502d0502a05025050240501f0501c0501805014050110500d050090500505001050000000000000000000000000000000000000000000000000000000000000000000000000000
000200002665024650226501f650000001a650136500c650096500065000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000400001705015050170500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000400002b050280502b0500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000500001135012350113500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
