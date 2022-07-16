pico-8 cartridge // http://www.pico-8.com
version 8
__lua__
maxs=0
life1=3000
round=1
w1={
 r1={0,0,0,0,3,0,0,0,0,0,0,0,0,0},
 r4={0,0,0,0,0,0,0,0,0,3,0,0,0,0},
 r7={0,0,0,0,0,0,3,0,0,0,0,0,0,0}
}

w2={
	r1={0,1,1,0,0,0,1,0,0,0,1,1,0,0},
	r7={0,0,0,0,0,0,3,0,0,0,0,0,0,0}
}

w3={
	r1={0,1,0,1,0,0,1,1,0,0,1,0,1,0},
	r5={0,1,0,1,0,0,1,1,0,0,1,0,1,0},

}
w4={
	r1={0,1,1,1,0,0,6,0,0,1,1,1,0,0},
	r3={0,1,1,1,0,0,0,0,3,1,1,1,0,0},
	r5={0,1,1,1,0,0,0,0,0,1,1,1,0,0}

}
w5={
	r1={0,0,1,1,1,0,6,0,6,0,1,1,1,0},
	r3={0,0,3,1,1,0,0,0,0,0,1,1,3,0},
	r5={0,0,1,1,1,0,0,0,0,0,1,1,1,0},
	r7={0,0,0,0,0,1,1,1,1,0,0,0,0,0}
}
w6={
	r1={0,1,0,1,2,0,0,0,2,1,0,1,0,0},
	r3={0,1,0,1,0,0,0,0,0,1,0,1,0,0},
	r5={0,1,0,1,0,1,1,1,0,1,0,1,0,0}
}
w7={
	r1={0,1,0,0,0,0,4,0,0,0,0,0,1,0},
	r2={0,1,0,0,0,0,0,0,0,0,0,0,1,0},
	r3={0,1,0,0,0,0,0,0,0,0,0,0,1,0},
	r4={0,1,0,3,0,0,0,0,0,0,0,0,1,0},
}
w8={
	r1={2,1,0,4,0,6,0,0,6,0,4,0,1,2},
	r3={0,1,0,0,0,0,3,0,0,0,0,0,1,0},
	r5={0,1,0,0,0,0,0,0,3,0,0,0,1,0},

}
w9={
	r1={2,1,0,0,6,0,1,0,6,0,0,1,2,0},
	r3={0,1,0,0,0,0,1,0,0,0,0,1,0,0},
	r4={0,1,1,0,0,1,4,1,0,0,1,1,0,0},
	r5={0,1,1,0,0,1,0,1,0,0,1,1,0,0}
}

---------------------------------------- segundo bloque
w10={
	r1={1,1,4,0,0,6,1,1,6,0,0,4,1,1},
	r2={0,0,0,0,6,0,0,0,0,6,0,0,0,0},
	r3={0,0,0,2,0,0,0,0,0,0,2,0,0,0},
	r5={0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	r7={0,0,0,3,0,0,3,0,0,0,3,0,0,0}
}
w11={
	r1={0,1,0,1,1,0,1,1,0,1,1,0,1,0},
	r3={0,1,0,1,1,0,1,1,0,1,1,0,1,0},
	r4={0,1,0,1,1,0,1,1,0,1,1,0,1,0},
	r5={0,1,0,1,1,0,1,1,0,1,1,0,1,0},
	r6={0,1,0,1,1,0,1,1,0,1,1,0,1,0}
	-- r7={0,1,0,1,1,0,1,1,0,1,1,0,1,0},
}
w12={
	r1={0,6,1,1,6,1,1,1,1,6,1,1,6,0},
	r7={0,0,2,0,0,6,0,0,6,0,0,2,0,0},
}
w13={
	r1={0,0,0,0,0,4,2,2,4,0,0,0,0,0},
	r4={0,0,4,0,0,0,0,0,0,0,0,4,0,0}
}
w14={
	r1={0,2,0,0,0,2,0,0,2,0,0,0,2,0},
	r2={0,0,2,0,2,0,0,0,0,2,0,2,0,0},
	r3={0,0,0,2,0,0,0,0,0,0,2,0,0,0}
}

w15={
	r3={0,0,3,0,3,0,5,0,0,3,0,3,0,0},
}

---------------------------------------- respawn functions

function read_w(w)

  if w == 1 then
    xc=w1
  elseif w==2 then
    xc=w2
  elseif w==3 then
    xc=w3
  elseif w==4 then
    xc=w4
  elseif w==5 then
    xc=w5
	elseif w==6 then
    xc=w6
	elseif w==7 then
    xc=w7
	elseif w==8 then
    xc=w8
	elseif w==9 then
    xc=w9
	elseif w==10 then
    xc=w10
	elseif w==11 then
    xc=w11
	elseif w==12 then
		xc=w12
	elseif w==13 then
		xc=w13
	elseif w==14 then
		xc=w14
	elseif w==15 then
		xc=w15
	elseif w==16 then
		xc=w16
  end

  for k,v in pairs(xc) do
  	local w=xc[k]
  	for j,z in pairs(w) do
      if z>0 then
        create_e(z,k,j)
      end
  	end
  end
end

function create_e(id,r,pos)

		local x
		local y
		if r=="r1" then x=176
		elseif r=="r2" then x=168
		elseif r=="r3" then x=160
		elseif r=="r4" then x=152
		elseif r=="r5" then x=144
		elseif r=="r6" then x=136
		elseif r=="r7" then x=128
		end
		y=pos*8

    if id==1 then
					add(masillas,{
						sp=23,
						x=x,
						iy=y,
						ix=x,
						y=y,
						scr=20,
						h=1*round,
						dx=x-64,
						st=1,
						wt=rnd(100)+25,
						t=0,
						spd=rnd(4)+2,
						box={x1=0, y1=0, x2=7, y2=7}
					})
    end

		if id==2 then
			add(zephyr,{
						sp=46,
						x=x,
						y=y,
						iy=y,
						scr=50,
						ix=x,
						h=5*round,
						wt=rnd(200)+100,
						st=1,
						dx=x-64,
						t=0,
						spd=rnd(4)+2,
						box={x1=0, y1=0, x2=7, y2=7}
					})
    end

		if id==3 then
			local d=-1
			if rnd(1)<0.5 then d=1 end
			add(enemies,{
					sp=20,
					mx=x,
					my=y,
					scr=10,
					d=d,
					spd=2,
					x=x,
					h=1*round,
					y=y,
					r=12,
					box={x1=0, y1=0, x2=7, y2=7}
				})
    end

		if id==4 then
			local d=-1
			if rnd(1)<0.5 then d=1 end
			add(finders,{
					sp=46,
					st=1,
					mx=x,
					my=y,
					scr=100,
					dir=1,
					lm=0,
					d=d,
					id=t*rnd(73),
					h=10*round,
					spd=1,
					dx=x-64,
					wt=rnd(300)+100,
					x=x,
					ix=x,
					iy=y,
					dy=0,
					y=y,
					r=12,
					box={x1=0, y1=0, x2=7, y2=7}
				})
    end

		if id==5 then --
			add(boss,{
				sp=13,
				x=x,
				lm=1,
				y=y,
				scr=1000,
				h=100*round,
				dx=x-64,
				st=1,
				wt=25,
				t=0,
				spd=1,
				box={x1=0, y1=0, x2=8, y2=16}
			})
			--music(4)
		end

		if id==6 then --
			add(masillas2,{
				sp=13,
				x=x,
				y=y,
				scr=80,
				iy=y,
				ix=x,
				h=7*round,
				dx=x-64,
				st=1,
				wt=rnd(130)+25,
				t=0,
				spd=rnd(2)+2,
				box={x1=0, y1=0, x2=7, y2=7}
			})
		end
end

-- weapons & fx ------------------------------------------------

function make_spk(x,y,fr,col)
 local s = {
	 x=x,
	 y=y,
	 frame=fr,
	 col=col,
	 t=0,
	 max_t = 8+rnd(4),
	 dx = 0,
	 dy = 0,
	 ddy = 0,
 }

 add(spk,s)
 return s
end

function mv_sprk(s)
 if (s.t > s.max_t) then
  del(spk,s)
 end
 s.x = s.x + s.dx
 s.y = s.y + s.dy
 s.t = s.t + 1
end

function make_smoke(x,y,size,col)
	local r=rnd(15)
	local s = {
		x=x,
		y=y,
		col=col,
		width=size,
		width_final = size + rnd(4)+.6,
		t=0,
		max_t = 4+rnd(1),
		dx = (rnd(.8)+.1),
		dy = rnd(.05),
		ddy = 0.2
	}

	add(smoke,s)
	return s
end

function m_smk(sp)
	if(sp.t > sp.max_t) then
		del(smoke,sp)
	else
		sp.width +=1
		sp.width = min(sp.width,sp.width_final)
	end

	if(t%6<3) then
		sp.y = sp.y + rnd(1)+.2
		sp.x = sp.x + (sp.dx*2)
	else
		sp.y = sp.y - rnd(1)-.2
		sp.x = sp.x + (sp.dx*2)
	end
	--sp.dy = sp.dy + sp.ddy
	sp.t = sp.t + 1
end

function draw_fx()
  for st in all(stars) do
		pset(st.x,st.y,13)
	end
	for s in all (smoke) do
		circfill(s.x,s.y,s.width, s.col)
	end

  explosiones()
	for f in all (flash) do
		rectfill(0,0,128,128,7)
	end
  for ex in all (explosions) do
		circ(ex.x+4,ex.y+3,ex.t/2,8+ex.t%3)
	end
	for s in all (spk) do
		spr(s.frame, s.x, s.y)
	end

end

function f_ball(x,y)
	add(balls,{
   x=x,
   y=y,
   r=4,
   vx=0,
   vy=0,
	 box={x1=0, y1=0, x2=7, y2=7}
  })
	sfx(4)
end




function missile(x,y)
	add(msls,{
   x=x,
   y=y,
   r=4,
   vx=0,
   vy=0,
	 sp=22,
	 ofst=rnd(2)+1,
	 box={x1=0, y1=1, x2=7, y2=4}
  })
	sfx(4)
end

function ctrl_boss()
	for p in all(boss) do


		if p.st==1 then
			make_smoke(p.x+12,p.y+8,rnd(6),7)
			p.x-=1
			if t%15==0 then
				missile(p.x-16,p.y)
				sfx(9)
				explode2(p.x,p.y,10)
			end
			if p.x <= p.dx then
				p.st=2
				--p.lm=1
				--p.wt =100
			end
		else
			if p.st==2 then
				p.wt-=1
				if p.lm==0 then
					if t%5==0 then
						missile(p.x,p.y)
						sfx(9)
						explode2(p.x,p.y,10)
					end
				end


				if p.wt<=0 then
					sfx(-1,2)
					p.lm=0
					local c=rnd(1)
					if c<=0.5 then
						p.dy=p.y-64
						p.dir=1
					else
						p.dy=p.y+64
						p.dir=2
					end
					p.wt=100
					p.st=3
				else
					if p.lm==0 then
						create_lb(p.x+4,p.y-4,p.wt,p.id)
						create_lb(p.x+4,p.y+18,p.wt,p.id)
						sfx(-1,2)
						sfx(11,2)
						p.lm=1
					else
						make_smoke(p.x+12,p.y-4,rnd(1),8)
						make_smoke(p.x+12,p.y+18,rnd(1),8)
						if t%30==0 then
							local d=-1
							if rnd(1)<0.5 then d=1 end
							local r1=rnd(90)+10
							add(enemies,{
									sp=20,
									mx=132,
									my=r1,
									d=d,
									scr=10,
									spd=2,
									h=1*round,
									x=132,
									y=r1,
									r=12,
									box={x1=0, y1=0, x2=7, y2=7}
								})

						end

					end
				end
			else
				p.wt-=1
				make_smoke(p.x+12,p.y+8,rnd(6),7)
				if p.wt<=0 then
					p.st=2
				end
				if p.dir==1 then
					if t%10==0 then
						missile(p.x,p.y)
						sfx(9)
						explode2(p.x,p.y,10)
					end
					p.y-=p.spd
					if p.y <=p.dy then

						p.y=p.dy
						--p.dx=p.x
						p.st=2
						p.wt =100
					end
				else
					if t%10==0 then
						missile(p.x,p.y)
						sfx(9)
						explode2(p.x,p.y,10)
					end
					p.y+=p.spd
					if p.y >=p.dy then

						p.y=p.dy
						--p.dx=p.x
						p.st=2
						p.wt =100
					end
				end
				if p.y>=90 then
					p.y=90
					p.st=2
				elseif p.y<=14 then
					p.y=14
					p.st=2
				end

			end

		end



		if coll(ship,p) and not ship.inm then
			rst_ship()
		end
	end

end

function explode(x,y)
  sfx(1)
	add(explosions, {x=x, y=y, t=0})
end

function explode2(x,y,r)
	local p1={
		x=x+4,
		y=y+4,
		r=r,
		f=0
	}
	add(particles1, p1)
end

function explosiones()
 for pt in all(particles1) do
  if #particles1 > 16 then
   del(particles1,pt)
  end

  if pt.f <=5 then
   circfill(pt.x+(rn(pt.r/1.5)-pt.r/3),pt.y+(rn(pt.r)-pt.r/1.5),pt.r-1+rn(2),epal[1])
   pt.r -= 1
   circfill(pt.x+(rn(pt.r*2)-pt.r),pt.y+rn(pt.r*2)-pt.r,pt.r/2,epal[2])
   circfill(pt.x+(rn(pt.r*2)-pt.r),pt.y+rn(pt.r*2)-pt.r,pt.r/2,epal[3])
  elseif pt.f <10 then
   circfill(pt.x,pt.y,pt.r,epal[3])
   pt.r -= pt.r/3
   circfill(pt.x+(rn(pt.r*2)-pt.r),pt.y+rn(pt.r*3)-pt.r,pt.r/2,epal[3])
   circfill(pt.x+(rn(pt.r*2)-pt.r),pt.y+rn(pt.r*3)-pt.r,pt.r/2,epal[4])
  elseif pt.f < 10+pt.r then
   circfill(pt.x+(rn(pt.r*4)-pt.r*2),pt.y+rn(pt.r*4)-pt.r*2,pt.r/2,epal[4])
   pt.r -= pt.r/4
   circfill(pt.x+(rn(pt.r*4)-pt.r*2),pt.y+rn(pt.r*4)-pt.r*2,pt.r/2,epal[5])
  end
  pt.f+=1
 end
end

function flashing()
	local f ={
		t=0,
	}
	add(flash, f)
end

--laser

function create_laser_spks(x,y)
  local y=y+rnd(2)+2
  for i=1,2 do
    create_point(x,y+i)
  end
end

function control_laser_spks()
  for pt in all(points) do
    pt.x+=1
    pt.t+=10
    pt.r-=0.01
    if pt.ttt>pt.dt then
      del(points,pt)
    end

    if pt.t>=pt.tt then
      pt.tt=rnd(60)+20
      pt.ttt+=pt.t
      pt.t=0
      pt.p+=1
      if pt.p>= 11 then
        pt.p=11
      end
    end

    if(t%5==0) then
			local c=rnd(1)
      if c < 0.5 then
        pt.y+=pt.ofst
      else
        pt.y-=pt.ofst
      end
    end

    if pt.x>128 then
      del(points,pt)
    end
  end
end

function create_point(x,y)
  local s = {
		x=x,
	  y=y,
	  t=1,
	  p=1, --posición paleta
	  r=rnd(1)+0.5,
	  ttt=0, --total live time
	  tt=rnd(60)+20, --temp time to change color
	  dt=rnd(600)+350, --tiempo final
	  ofst=rnd(0.5),
	  h1=h1,
	  h2=h2
	}

  add(points,s)

end

function draw_bean()

  for l in all (lasers) do
    local h1=l.y-rnd(3)
    local h2=h1+2
    rectfill(l.ix,h1,l.x,h1+4,10)
    rectfill(l.ix,h2,l.x,h2+1,7)
  end

  for pt in all(points) do
    pset(pt.x,pt.y,laserb[pt.p])
  end
end

function create_lb(x,y,t,id)
  local l = {
	}
  l.x=x
  l.y=y
  l.ix=l.x --x inicial
  l.fx=l.x-l.ix --x final
  l.t=1
	l.id=id
  --l.c=0 -- counter tamaño
  --l.ttt=0 --total live time
  l.dt=t --tiempo final
  --l.ofst=rnd(0.5)
  --l.h1=h1
  --l.h2=h2
	l.box={x1=l.x, y1=l.y, x2=l.ix, y2=l.y}
  add(lasers,l)
end

function control_laserbean()

  for l in all(lasers) do
    l.t+=1
    if l.t>=l.dt then del(lasers,l) end
    l.x-=5
		make_smoke(l.x,l.y,rnd(4),7)

    if l.x<=l.fx then
       l.x=l.fx
       create_laser_spks(l.x,l.y-6)
       create_laser_spks(l.x,l.y-2)
			 make_smoke(l.x,l.y,rnd(6),5)
    end
		local x1=l.x
	 	local x2=l.ix
	 	local y1=l.y
	 	local y2=2

		l.box={x1=l.x, y1=0, x2=l.x+x2, y2=3}


  end
  control_laser_spks()
end

function destroy_lb(id)
	for l in all(lasers) do
		if l.id==id then
			del(lasers,l)
			sfx(-1,2)
		end
	end
end

--camera

function shk_cam(x,y)
	camera(cos(t/x), cos(t/y))
end

function reset_camera()
	camera()
end

--init

function _init()
	sfx(-1,2)
	sfx(22)
	col=1
	fp=84
	t=0
	stars={}
	for i=1,128 do
		add(stars,{
			x=rnd(128),
			y=rnd(120),
			s=rnd(2)+1
		})
	end
	ship = {
		sp=1,
		x=10,
		y=60,
		fm=1,
		h=3,
		p=0, --score
		box={x1=0, y1=1, x2=7, y2=6},
		t =0,
		fp=84, --fire power ship
		inm = false,
		w=1, --weapon
		spd=1 --speed
	}

	bullets = {}
	enemies={}
	balls={}
	explosions={}
	flash={}
	particles1={}
	epal={9,13,6,5} --particles explosion palette enemies1
	smoke={}
  spk = {}
	orbs={}
	masillas={}
	masillas2={}
	zephyr={}
	finders={}
	bot={}
	msls={}
	wn=0--cambiar para usar continues (power up)
	laserb={7,10,15,6,9,14,13,4,5,2,1,0}
  points={}
  lasers={}
	boss={}
	multi=1
	life1=3000
	round=1

	begin()
end

function win()

	lst = time()
	if ship.p > maxs then
		maxs = ship.p
	end
  ship.x=-50
_update= update_win
_draw = draw_win
end

function update_win()


	t+=1
	col+=1
	if btnp(4) and (time() - lst) > 1 then
		flashing()
		music(2)
		round+=1
		wn=1
		_update= update_game
		_draw = draw_game
	end
	control_fx()
	control_enemies()
end

function draw_win()
	reset_camera()
	cls()
  draw_fx()
  draw_aliens()
	draw_bean()
	for i=1,9 do
		if t%10>3 then
			spr(47+i, 26+i*8, 3)
		end

  end
	print_centered("congratulations", 16, col)
  print_centered("you destroy the alien menace", 24, col)
	print_centered("next difficulty level: "..round+1, 36, col)
	print_centered("your score: "..maxs, 104, 8)
	print_centered("press fire to restart", 112, col)
end

function begin()
	lst = time()
	_update = update_welcome
	_draw = draw_welcome

end

--orbs

function create_orb(x,y,id)
	local i=id
	local o={
		x=x,
		y=y,
		id=id,
		box={x1=0, y1=0, x2=7, y2=7}
	}
	add(orbs,o)
end

function control_orbs()
	for o in all (orbs) do
		o.x-=rnd((.7)+.1)
		if o.x <0 then
			del(orbs,o)
		end
		if coll(o,ship) then
			if o.id==1 then
				if ship.spd<3 then
					ship.spd+=1
					for st in all(stars) do
							if ship.spd==1 then
								st.s=rnd(3)+1
							elseif ship.spd==2 then
								st.s=rnd(4)+1
							elseif ship.spd==3 then
								st.s=rnd(4)+2
							end
					end
					flashing()
					sfx(17)
					del(orbs,o)
				end
			elseif o.id==2 and ship.fm!=2 then
					ship.fm=2
					flashing()
					sfx(17)
					sfx(22)
					del(orbs,o)
			elseif o.id==3 and ship.fm!=3 then
					ship.fm=3
					flashing()
					--sfx(17)
					sfx(22)
					del(orbs,o)
			elseif o.id==4 then
					fp=300
					flashing()
					sfx(17)
					music(0)
					del(orbs,o)
			elseif o.id==5 and #bot <3 then
					addbot(ship.x,ship.y)
					flashing()
					sfx(23)
					del(orbs,o)
			end

		end
	end
end

function ctrl_scr(scr)


		if ship.p>=life1 then
			life1+=3000
			music(2)
			if ship.h <3 then
				ship.h+=1
			else
				multi+=1
			end
		end

	ship.p += scr*multi
end

--updates & draw

function draw_welcome()
	cls()
  draw_fx()
	col+=1
	map(0, 0, 7, 4, 14, 7)
	print_centered("1up or score multiplier", 80, 11)
	print_centered("every 3000 pts", 88, 8)
  print_centered("press fire to start", 120, col)
end

function update_welcome()
	--t += 1

	if btn(4) and (time() - lst) >= 0.3 then
		music(2)
		_update = update_game
		_draw = draw_game
	end
  control_fx()
end

function game_over()
	sfx(30)
  lst = time()
	if ship.p > maxs then
		maxs = ship.p
	end
  ship.x=-50
	_update = update_over
	_draw = draw_over
end

function update_over()
	ship.x=-60
	t=t+1
  col+=1


	ctrl_boss()
	control_enemies()
	control_bullets()
	control_fx()
	control_orbs()
	control_laserbean()
	if btnp(4) and (time() - lst) > 1 then
		_init()
	end
end

function draw_aliens()
	for b in all (bullets) do
		spr(b.sp,b.x,b.y)
	end

	for t in all(bot) do
		circfill(t.x,t.y,1,12)
		circfill(t.x,t.y,0.5,15)
	end

	for p in all(finders) do
		if(t%16>4) then
			p.sp=30
		else
			p.sp=31
		end
		spr(p.sp,p.x,p.y)
	end

  for e in all (enemies) do
		if(t%8<4) then
			e.sp=20
		else
			e.sp=21
		end
		spr(e.sp,e.x,e.y)
	end

	for m in all (masillas) do
		local r1=rnd(2)+0.1
		local r2=rnd(2)+0.1
		if(t%6<3) then
			m.sp=23
			r2=r2*-1
		else
			m.sp=24
		end
		spr(m.sp,m.x+r2,m.y)
	end

	for m in all (masillas2) do
		local r1=rnd(1)+0.1
		local r2=rnd(1)+0.1
		if(t%6<3) then
			m.sp=13
			r2=r2*-1
		else
			m.sp=14
		end
		spr(m.sp,m.x+r2,m.y)
	end

	for z in all (zephyr) do
		if(t%8>4) then
			z.sp=46
		else
			z.sp=47
		end
		spr(z.sp,z.x,z.y)
	end

	for f in all(balls) do
   circfill(f.x+4,f.y+4,f.r,11)
  end

	for m in all(msls) do
   spr(m.sp,m.x,m.y)
  end

	for b in all(boss) do
		if b.st==2 then
			map(14, 4, b.x-8, b.y-8, 4, 4)
		else
			map(14, 0, b.x-8, b.y-8, 4, 4)
		end

  end

  for o in all (orbs) do
		local x=o.x
		local y=o.y
		local id=o.id
		if (t%8>4) then
			if id==1 then
				spr(6,x,y)
			elseif id==2 then
				spr(7,x,y)
			elseif id==3 then
				spr(8,o.x,o.y)
			elseif id==4 then
				spr(9,x,y)
			elseif id==5 then
				spr(12,x,y)
			end
		else
			spr(11,x,y)
		end
	end
end

function draw_over()
	reset_camera()
	cls()
  draw_fx()
  draw_aliens()
	draw_bean()
	for i=1,9 do
   spr(36+i, 20+i*8, 1)
  end
  print_centered("wave: "..wn.." score: "..ship.p, 12, col)
	print_centered("your best score: "..maxs, 20, 8)
	print_centered("press fire to restart", 112, col)
end

--collisions

function abs_box(s)
	local box={}
	box.x1 = s.box.x1 + s.x
	box.y1 = s.box.y1 + s.y
	box.x2 = s.box.x2 + s.x
	box.y2 = s.box.y2 + s.y
	return box
end

function coll(a,b)
	local boxa=abs_box(a)
	local boxb=abs_box(b)
	if boxa.x1 > boxb.x2 or boxa.y1 > boxb.y2 or boxb.x1 > boxa.x2 or boxb.y1 > boxa.y2 then
		return false
	end
	return true
end

-----------------------

function rn(n)
 return flr(rnd(n))
end

--control ship

function fire()

	if (bot) then
		for e in all (bot) do
			local z = { --normal
				sp=3,
				x=e.x,
				y=e.y,
				dx=3,
				dy=0,
				box={x1=5, y1=4, x2=8, y2=4}
			}
			add(bullets,z)
			fp-=8
		end
	end

	if ship.fm==1 then
		local b = { --normal
			sp=3,
			x=ship.x,
			y=ship.y,
			dx=3,
			dy=0,
			box={x1=5, y1=4, x2=8, y2=4}
		}

		add(bullets,b)
		sfx(0)
		fp-=12

	elseif ship.fm==2 then
		local b = { --normal
			sp=3,
			x=ship.x,
			y=ship.y+2,
			dx=3,
			dy=0,
			box={x1=5, y1=4, x2=8, y2=4}
		}
		local b2 = { --double
			sp=3,
			x=ship.x,
			y=ship.y-2,
			dx=3,
			dy=0,
			box={x1=5, y1=4, x2=8, y2=4}
		}
		add(bullets,b)
		add(bullets,b2)
		fp-=15
		sfx(0)

	elseif ship.fm==3 then

		local b = { --normal
			sp=3,
			x=ship.x,
			y=ship.y,
			dx=3,
			dy=0,
			box={x1=5, y1=4, x2=8, y2=4}
		}

		local c = { --down 45
			sp=4,
			x=ship.x,
			y=ship.y,
			dx=3,
			dy=.5,
			box={x1=7, y1=4, x2=8, y2=4}
		}

		local d = { --up 45
			sp=4,
			x=ship.x,
			y=ship.y,
			dx=3,
			dy=-.5,
			box={x1=4, y1=3, x2=7, y2=3}
		}
		add(bullets,b)
		add(bullets,c)
		add(bullets,d)
		fp-=25
		sfx(0)

	end
end

function print_centered(str,y,c)
  print(str, 64 - (#str * 2), y, c)
end

function reset_stars()
	for st in all(stars) do
			st.s=rnd(2)+1
	end
end

function reset_bots()
	for v in all (bot) do
		del(bot,v)
	end
end

function control_enemies()

	for p in all(finders) do
		if p.st==1 then
			p.x-=p.spd
			if p.x <= p.dx then
				p.x=p.dx
				p.st=2
				p.wt =100
				p.dx = p.x-32
			end
		else
			if p.st==2 then
				p.wt-=1
				if p.wt<=0 then
					sfx(-1,2)
					p.lm=0
					local c=rnd(1)
					if c<=0.5 then
						p.dy=p.y-32
						p.dir=1
					else
						p.dy=p.y+32
						p.dir=2
					end
					p.wt=100
					p.st=3
				else
					if p.lm==0 then
						create_lb(p.x,p.y+4,p.wt,p.id)
						sfx(-1,2)
						sfx(11,2)
						p.lm=1
					end
				end
			else
				p.wt-=1
				if p.wt<=0 then
					p.dx=p.x-32
					p.st=1
				end
				if p.dir==1 then
					p.y-=p.spd
					if p.y <=p.dy then
						p.y=p.dy
						p.dx=p.x-32
						p.st=1
						p.wt =200
					end
				else
					p.y+=p.spd
					if p.y >=p.dy then
						p.y=p.dy
						p.dx=p.x-32
						p.st=1
					end
				end
				if p.y>=110 then
					p.y=110
					p.st=1
				end

				if p.y<=10 then
					p.y=10
					p.st=1
				end

			end

		end

		if p.x <= 0 then
			p.x=p.ix
			p.dx=p.x-64
			p.y=p.iy
			if p.spd<8 then
				p.spd+=0.5
			end
			p.st=1
			if p.scr>5 then p.scr-=5 end
		end

		if coll(ship,p) and not ship.inm then
			rst_ship()
			del(finders,p)
			destroy_lb(p.id)
			sfx(-1,2)
		end
	end

	for z in all (zephyr) do
		if z.x <= 0 then
			z.x=z.ix
			z.dx=z.x-64
			z.y=z.iy
			if z.spd<5 then
				z.spd+=0.5
			end
			if z.scr>5 then z.scr-=5 end
		end
		if coll(ship,z) and not ship.inm then
			rst_ship()
			del(zephyr,z)
		end
		if(t%6<3) then
			col=12
		else
			col=13
		end

		if z.st == 1 then

			z.x-=z.spd
			if z.x <= z.dx then
				z.x=z.dx
				z.st=2
				z.wt =rnd(400)+200
				z.dx = z.x-32
				if(t%6<3) then
					f_ball(z.x,z.y)
				end
			end
		else
			local c=rnd(1)
			if c>0.99 then
				f_ball(z.x,z.y)
			end
			z.wt-=1
			if z.wt<=1 then
				z.st =1
				z.wt = rnd(400)+2
				if z.x<=50 then
					z.dx =z.x-100
				else
					z.dx =z.x-32
				end
				f_ball(z.x,z.y)
			end
		end
	end

	for m in all(msls) do
		m.x-=rnd(1)+0.5
		if m.x <= -5 then
		 del(msls,m)
	 	end
		local c=rnd(1)
    if(t%5==0) then
      if c < 0.5 then
        m.y+=m.ofst
      else
        m.y-=m.ofst
      end
    end


	 	if(t%30==0) then
	 		make_smoke(m.x+4,m.y+4,.2,6)
	 	else
	 		make_smoke(m.x+4,m.y+4,.1,7)
	 	end
		if coll(ship,m) and not ship.inm then
			rst_ship()
			del(msls,m)
	 	end
	end

	----------------------

	for l in all(lasers) do
	 if coll(ship,l) and not ship.inm then
		 rst_ship()
	 end
  end

	for f in all(balls) do
   f.x-=2
	 if f.x < -10 then
		 del(balls,f)
	 end
	 if(t%6<3) then
		 make_smoke(f.x,f.y+4,.8,3)
	 else
		 make_smoke(f.x,f.y+4,.8,11)
	 end

	 if coll(ship,f) and not ship.inm then
		 rst_ship()
		 del(balls,f)
	 end
  end

	for e in all (enemies) do
		e.mx-=1.3
		e.x= e.r * sin (e.d*t/50) + e.mx
		e.y= e.r *cos(t/50) +e.my
		if coll(ship,e) and not ship.inm then
			rst_ship()
			del(enemies,e)
		end
		if e.x < -10 then
			del(enemies,e)
		end
	end

	for m in all (masillas) do
		if m.x < 0 then
			m.x=m.ix
			m.dx=m.x-64
			m.y=m.iy
			if m.spd<5 then
				m.spd+=0.5
			end

			m.st=1
			m.wt=5
			if m.scr>5 then m.scr-=5 end
		end
		if(t%6<3) then
			make_smoke(m.x+6,m.y+4,.2,2)
		else
			make_smoke(m.x+6,m.y+4,.2,8)
		end
		if m.st == 1 then
			m.x-=m.spd
			if m.x <= m.dx then
				m.x=m.dx
				m.st=2
				m.wt =rnd(100)+25
				m.dx = m.x-32
			end
		else
			m.wt-=1
			if m.wt<=1 then
				m.wt=rnd(100)+25
				local c=rnd(1)
				if c>0.7 then
					if m.x<=50 then
						m.dx =m.x-100
					else
						m.dx =m.x-32
					end
					m.st=1
				end
				if c<0.1 then
					local d=-1
					if rnd(1)<0.5 then d=1 end
						add(enemies,{
								sp=20,
								mx=m.x,
								my=m.y,
								d=d,
								h=1*round,
								scr=10,
								spd=2,
								x=m.x,
								y=m.y,
								r=12,
								box={x1=0, y1=0, x2=7, y2=7}
							})
						sfx(5)
						explode2(m.x,m.y,10)
				end
			end
		end


		if coll(ship,m) and not ship.inm then
			rst_ship()
			del(masillas,m)
		end
	end

	for m in all (masillas2) do
		if m.x < 0 then
			m.x=m.ix
			m.dx=m.x-64
			m.y=m.iy
			if m.spd<5 then
				m.spd+=0.5
			end
			m.st=1
			if m.scr>5 then m.scr-=5 end
		end
		if(t%6<3) then
			make_smoke(m.x+6,m.y+4,.2,12)
		else
			make_smoke(m.x+6,m.y+4,.2,13)
		end
		if m.st == 1 then
			m.x-=m.spd
			if m.x <= m.dx then
				m.x=m.dx
				m.st=2
				m.wt =rnd(50)+25
				m.dx = m.x-16
			end
		else
			m.wt-=1
			if m.wt<=1 then
				m.wt=rnd(100)+25
				local c=rnd(1)
				if c>0.7 then
					if m.x<=70 then
						m.dx =m.x-100
					else
						m.dx =m.x-32
					end
					m.st=1
				end
				if c<0.3 then
					local d=-1
					if rnd(1)<0.5 then d=1 end
						for i=1,3 do
							missile(m.x,m.y+i*2)
						end
						sfx(9)
						explode2(m.x,m.y,10)
				end
			end
		end


		if coll(ship,m) and not ship.inm then
			rst_ship()
			del(masillas,m)
		end
	end
end

function rst_ship()
	explode(ship.x,ship.y)
	explode2(ship.x,ship.y,30)
	flashing()
	sfx(2)
	fp=16
	ship.inm = true
	ship.h -=1
	ship.fm=1
	ship.spd=1
	multi=1
	reset_bots()
	reset_stars()
	if ship.h <=0 then
		del(ship)
		game_over()
	end
end

function addbot(x,y)
	add(bot,{
		sp=23,
		x=x,
		y=y,
		d=1,
		pos=rnd(50)+20,
		r=12,
		mx=x,
		my=y,
	})
end

function control_bot()
	for w in all (bot) do
		w.mx=ship.x+4
		w.my=ship.y+4
		w.x= w.r * sin (1*t/w.pos) + w.mx
		w.y= w.r *cos(1*t/w.pos) +w.my
	end
end

function control_player()
	if not btnp(4) and fp<84 and not ship.inm then
		fp+=1
	end

	if ship.inm then
		ship.t+=1
		shk_cam(3,2)
		if ship.t > 60 then
			ship.inm = false
			ship.t = 0
			reset_camera()
		end
	end

	if btn(0) then ship.x-=ship.spd end
	if btn(1) then ship.x+=ship.spd end
	if btn(2) then ship.y-=ship.spd end
	if btn(3) then ship.y+=ship.spd end
	if btnp(4) and fp>=24 and not ship.inm then fire() end
	if ship.x<4 then ship.x =4 end
	if ship.x>124 then ship.x =120 end
	if ship.y<8 then ship.y =8 end
	if ship.y>112 then ship.y =112 end
end

function control_bullets()

	for b in all (bullets) do
		b.x+=b.dx
		b.y+=b.dy
		if b.x<-30 or b.x>128 or b.y<-20 or b.y>128 then
			del(bullets,b)
		end

		for e in all(enemies) do
			if coll(b,e) then
				e.h-=1

				if e.h<=0 then
					ctrl_scr(e.scr)
					explode2(e.x,e.y,15)
					del(enemies,e)
				end
				make_smoke(e.x+6,e.y+4,1,14)
				del(bullets,b)
				explode(e.x,e.y)
        --local cc=rnd(15)+1

			end
		end

		for m in all(msls) do
			if coll(b,m) then
				del(msls,m)
				del(bullets,b)
				make_smoke(m.x+6,m.y+4,1,14)
				explode2(m.x,m.y,15)
				explode(m.x,m.y)
			end
		end

		for p in all(finders) do
			if coll(b,p) then
				del(bullets,b)
				make_smoke(p.x+6,p.y+4,1,10)
				explode2(p.x,p.y,11)
				p.h-=1
				sfx(31)
				if p.h<=0 then
					sfx(10)
					flashing()
					explode(p.x,p.y)
					explode2(p.x,p.y,30)
					ctrl_scr(p.scr)
					destroy_lb(p.id)
					for i=1,32 do
           s=make_spk(
           p.x, p.y, 83, 0)
           s.dx = cos(i/32)/2
           s.dy = sin(i/32)/2
           s.max_t = 100
           s.ddy = 1
           s.frame=83+rnd(4)
           s.col = 7
          end

					for i=1,1 do
	         s=make_spk(
	         p.x, p.y, 67, 0)
	         s.dx = cos(2/4)/2
	         s.dy = sin(2/4)/2
	         s.max_t = 50
	         s.ddy = 0.01
	         s.frame=67
	         s.col = 7
	        end
					del(finders,p)
					--explode(p.x,p.y)
				end

			end
		end

		for v in all(boss) do
			if coll(b,v) then

				del(bullets,b)
				make_smoke(v.x+6,v.y+4,1,10)
				explode2(v.x,v.y,11)
				v.h-=1
				sfx(32)
				if v.h<=0 then

					ship.inm=1
					sfx(10)
					flashing()
					explode(v.x,v.y)
					explode2(v.x,v.y,30)
					ctrl_scr(v.scr)
					destroy_lb(v.id)
					music(7)
					del(boss,v)
				end

			end
		end

		for m in all(masillas) do
			if coll(b,m) then
				del(bullets,b)
				make_smoke(m.x+6,m.y+4,1,14)
				explode(m.x,m.y)
				m.h-=1
				if m.h<=0 then
					ctrl_scr(m.scr)
					--ship.p += m.scr
					explode2(m.x,m.y,15)
					local cc=rnd(15)+1
	        for i=1,cc do
	         s=make_spk(
	         m.x, m.y, 96, 0)
	         s.dx = cos(i/cc)/2
	         s.dy = sin(i/cc)/2
	         s.max_t = 20
	         s.ddy = 0.01
	         s.frame=80+rnd(7)
	         s.col = 7
	        end
					for i=1,1 do
	         s=make_spk(
	         m.x, m.y, 66, 0)
	         m.dx = cos(2/4)/2
	         m.dy = sin(2/4)/2
	         m.max_t = 30
	         m.ddy = 0.01
	         m.frame=66
	         m.col = 7
	        end
					del(masillas,m)
				end
			end
		end

		for m in all(masillas2) do
			if coll(b,m) then
				make_smoke(m.x+6,m.y+4,1,14)
				del(bullets,b)
				sfx(8)
        local cc=rnd(7)+2
        for i=1,cc do
         s=make_spk(
         m.x-4, m.y, 96, 0)
         s.dx = cos(i/cc)/4
         s.dy = sin(i/cc)/4
         s.max_t = 20
         s.ddy = 0.01
         s.frame=96+rnd(2)
         s.col = 7
        end
				m.h-=1
				if m.h<=0 then
					sfx(10)
					ctrl_scr(m.scr)
					--ship.p += m.scr
					del(masillas2,m)
					explode(m.x,m.y)
					explode2(m.x,m.y,30)

          for i=1,32 do
           s=make_spk(
           m.x, m.y, 96, 0)
           s.dx = cos(i/32)/2
           s.dy = sin(i/32)/2
           s.max_t = 60
           s.ddy = 1
           s.frame=96+rnd(7)
           s.col = 7
          end

					-- for i=1,1 do
	        --  s=make_spk(
	        --  m.x, m.y, 66, 0)
	        --  m.dx = cos(2/4)/2
	        --  m.dy = sin(2/4)/2
	        --  m.max_t = 30
	        --  m.ddy = 0.01
	        --  m.frame=66
	        --  m.col = 7
	        -- end
				end
			end
		end

		for z in all(zephyr) do

			if coll(b,z) then
				del(bullets,b)
				explode2(z.x,z.y,15)
				sfx(3)

				z.h-=1

				if z.h<=0 then
					explode(z.x,z.y)
					flashing()
					local d = rnd(1)
					if d <=0.1 then
						r=3
					elseif d <=0.3 then
						r=2
					elseif d <=0.7 then
						r=1
					elseif d >=0.9 then
						r=4
					else
						r=5
					end

          for i=1,32 do
           s=make_spk(
           z.x, z.y, 96, 0)
           s.dx = cos(i/32)/2
           s.dy = sin(i/32)/2
           s.max_t = 60
           s.ddy = 1
           s.frame=96+rnd(7)
           s.col = 7
          end

	        -- for i=1,1 do
	        --  s=make_spk(
	        --  z.x, z.y, 67, 0)
	        --  z.dx = cos(2/4)/2
	        --  z.dy = sin(2/4)/2
	        --  z.max_t = 120
	        --  z.ddy = 0.01
	        --  z.frame=67
	        --  z.col = 7
	        -- end

					create_orb(z.x,z.y,r)
					ctrl_scr(z.scr)
					--ship.p += z.scr
					del(zephyr,z)


				end
			end
		end

	end
end

function control_fx()

	foreach(smoke, m_smk)
	foreach(spk, mv_sprk)
	for st in all(stars) do
		st.x-=st.s
		if st.x<=0 then
			st.x=128
			st.y=rnd(120)
		end
	end

	for ex in all (explosions) do
		ex.t+=1
		if ex.t>=15 then
			del(explosions,ex)
		end
	end

	for f in all (flash) do
		f.t+=1
		if f.t>2 then
			f.t = 0
			del(flash,f)
		end
	end
end



function update_game()
	t=t+1
	col+=1
	cnt=(#masillas+#enemies+#zephyr+#masillas2+#finders+#boss)
	if cnt == 0 then
		if wn<15 then
			wn+=1
			local d = rnd(1)
			if d <=0.1 then
				r=3
			elseif d <=0.3 then
				r=2
			elseif d <=0.7 then
				r=1
			elseif d >=0.9 then
				r=4
			else
				r=5
			end
			local r2=rnd(104)+8
			create_orb(160,r2,r)
			read_w(wn)
		else
			win()
		end

	end



	control_enemies()
	ctrl_boss()
	control_laserbean()
	control_player()
	control_bullets()
	control_fx()
	control_orbs()
	control_bot()

end

function hud()
	local bc = 9
	local tc = 7
	local sc = 12
	local size=fp
	if fp<0 then size=0 end
	if fp>80 then
		bc=11
	end
	if fp>95 then
		if(t%6<3) then
			bc=11
		else
			bc=7
		end
	end
	if fp<70 then
		bc = 15
		tc = 9
	end
	if fp<30 then
		bc = 8
		tc = 5
	end
	print("score",1,0,13)
	print(ship.p,24,0,12)
	if multi>1 then
		if(t%6<3) then
			print("x"..multi,40,0,10)
		end
	end




	print("fire power", 0, 122, 13)
	rectfill(44,122,127,126,13)
	rectfill(44,122,(44+size),126,bc)
	rect(44,122,127,126,5)

	print("spd ",50,0,9)
	for i=1,3 do
		if i<=ship.h then
			spr(33,98+8*i,0)
		else
			spr(34,98+8*i,0)
		end
	end
	for i=1,3 do
		if i<=ship.spd then
			spr(35,58+4*i,0)
		else
			spr(36,58+4*i,0)
		end
	end
	--print("memory "..stat(0),1,5,3) -- memory usage in [0..1024]
	--print("cpu "..stat(1),80,5,4) -- cpu usage; 1.0 == 100% cpu at 30fps
end

function draw_game()
	cls()

  if not ship.inm or t%8 <4 then
		spr(ship.sp,ship.x,ship.y)
	end
  draw_fx()
	draw_bean()
	draw_aliens()
	hud()
end

__gfx__
00000000000000000000000000000000000000000000000000677600007667000066770000676700006666000057750000577500000000000000000000077777
00000000666000006660000000000000000000000000000005017170051111600511107005010160050101600610007006100070011dd16060dd160000777777
007007000826111008261110000000000000000000c7c000501a0116519928175011090650b0031751660016600000156000c01506d075dd0d075dd007777777
00077000d65dccccd65dcccc000099980000009800777000509a70175010111650a900175b0b303750185c1660000007600cfc0700000610000c6100aaaaaaaa
00077000011ddd77011ddd77000000000000000000c7c0005009a7175000011750a901165b03b0b650169516600000076000c00700000610000c6100aaaaaaaa
0070070000199155001991550000000000000000000000005000a1165199281750000906503b0b1651000116710000057000000506d075dd0d075dd007777777
000000000000000000000000000000000000000000000000050a1060050110600501006005001060051010600600015006000050011dd16060dd160000777777
00000000000000000000000000000000000000000000000000555500005555000055550000555500005555000076660000766600000000000000000000077777
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000882000000000
000000000000000000000000000000000e0000e0000e00000000000000e8898000eee98000000000000000000000000000000000000000000004000800888400
00000000000000000000000000000000000880000008800000005000000072e90e00a2e900000000000000000000000000000000000000008590000085900022
000000000000000000000000000000000082e800008e28e07d66000000000a50000649500000000000000000000000000000000000000000fca96200fca9d500
00000000000000000000000000000000008e28000e82e8000000500000000a50000649500000000000000000000000000000000000000000fca96020fca9d500
00000000000000000000000000000000000880000008800000000000000072e90800a2e900000000000000000000000000000000000000008590000085900022
000000000000000000000000000000000e0000e00000e00000000000008889200088892000000000000000000000000000000000000000000004000800888400
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000248000000000
000000000000000000000000000a0000000500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000660000005500000000a0000000500000333330003333300333000303333333000000000033333003330030033333330333333000bbbb93000000003
000000000085cc0000555500000aa00000055000bbb00bb0bbb00bb0bbbb0bb0bbb0000000000000bbb00bb0bbb00b00bbb00000bbb00bb03000031000bbbb3a
0000000000695600005555000000a00000005000aaa00000aaa00aa0aaa0f0f0aaa0000000000000aaa00aa0aaa00a00aaa00000aaa00aa000a1a3930501a139
0000000000000000000000000000a00000005000777077707770077077700070777777000000000077700770777007007777770077777700001a5393050a1a39
0000000000000000000000000000000000000000aaa00aa0aaaaaaa0aaa000a0aaa0000000000000aaa00aa0aaa0aa00aaa00000aaa00aa03000031000bbbb3a
0000000000000000000000000000000000000000bbb00bb0bbb00bb0bbb000b0bbb0000000000000bbb00bb0bbbbb000bbb00000bbb00bb00bbbb93000000003
00000000000000000000000000000000000000000333330033300330333000303333333000000000033333003333000033333330333003300000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33300330033333003330033000000000333000300333330033300030003333000000000000000000000000000000000000000000000000000000000000000000
bbb00bb0bbb00bb0bbb00bb000000000bbb000b000bbb000bbbb00b000bbbb000000000000000000000000000000000000000000000000000000000000000000
aaa00aa0aaa00aa0aaa00aa000000000aaa000a000aaa000aaaa00a000aaaa000000000000000000000000000000000000000000000000000000000000000000
77700770777007707770077000000000777070700077700077707070007770000000000000000000000000000000000000000000000000000000000000000000
0aaaaa00aaa00aa0aaa00aa000000000aaa0a0a000aaa000aaa0a0a000aaa0000000000000000000000000000000000000000000000000000000000000000000
00bbb000bbb00bb0bbb00bb0000000000bbb0bb000bbb000bbb00bb0000000000000000000000000000000000000000000000000000000000000000000000000
00333000033333000333330000000000003303000333330033300330003330000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000005d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05000050000dddd50002252005550006000000000000000000000000000000000000000000000000000000000000111111111000000000000000000000000000
000550000000005d0040d245100000000000000000000000000000000000000000000000000000000000000000017777d7777100000000000000000000000000
0055d500006605560000065051d0050000000000000000000000000000000000000000000000000000000000055166766666d100000000000000111111111000
005d550000605056000006505d55d00500000000000000000000000000000000000000000000000088866666665155d5dd5551000000000000017777d7777100
000550000000005d0000d24510500000000000000000000000000000000000000000000000000000000000000001ddddd6ddd10000000000055166766666d100
0d0000d000ddddd5004405200006000d000000000000000000000000000000000000000000000000000111100001dd1111551000bbb66666665155d5dd555100
000000000d000000000000000000600000000000000000000000000000000000000000000000000000066d610000116555555500000000000001ddddd6ddd100
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000061000016dddddd600000000000001dd1111551000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000610015166666666000000001d100151666666660
000000000000000000000000000000000000000000000000000aa0000000000000000000000000000000000006155551555555600000001d1d15555155555560
000000000002000000000000000800000000e000000090000000000000000000000000000000000000000000006dddd51ddddd10000000d1006666651ddddd10
00050000000000000000e00000008000000e00000000000000000000000800000000000000000000000000000067777751dddd11000000d010dddddd51dddd11
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001111111111dd0000001d10001111111111dd
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001117677777711100000001001b176777777111
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066116eeeeee610000000000001b16bbbbbb6100
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001116666666611100000001001b166666666111
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001111111111dd0000001d10001111111111dd
0000000000000000000000000000000000000000000000000003000000000000000000000000000000000000006ddddd51dddd11000000d010dddddd51dddd11
0000d000000c000000000000000b00000000c0000000d0000000000000000000000000000000000000000000006777751ddddd10000000d1006666651ddddd10
000d000000000000000060000000b000000c00000000000000000000000b000000000000000000000000000006155551555555600000001d1d15555155555560
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000610015166666666000000001d100151666666660
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000061000016dddddd600000000000001dd1111551000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000066d610000116555555500000000000001d6ddddddd100
00000000000000000000000000000000000000000000000000000000000000000000000000000000000111100001dd1111551000bbb666666651d55555d55100
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001d6ddddddd1000000000005516666d6676100
00000000000000000000000000000000000000000000000000000000000000000000000000000000888666666651d55555d5510000000000000177d777777100
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005516666d6676100000000000000111111111000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000177d777777100000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000111111111000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000c0000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000c00000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000c000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000cc00000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000cc000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000cc0000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000099990000000000000000000c000000000009999000000000000000000000000000000000000000000000
000000000000000000099999990000000000000000098888900000000000000000cc000000000098888900000000000000000000000000000000000000000000
00000000000000000998888888999999000000000998aaaa89000000000000000cc000000000998aaaa890000000000000000000000000000000000000000000
0000000000000009988aaaaaaa88888890000009988abbba89000000000000000c000000009988abbba889000000000000000000000000000000000000000000
00000000000000988aabbbbbbbaaaaaa890000988aabbbba890000000000000cc00000000988aabbbbbaa8909999000000000000000000000000000000000000
000000000000098aabbbbbbbbbbbbba89000098aaabbbbba89000c00000000cc0000000098aaabbbbbbaaa898888900000000000000000000000000000000000
00000000000098abbbbbaaabbbbbaa890000009888abbbba890000cc00c00cc00000000009888abbbba88888aaa8900000000000000000000000000000000000
0000000000098abbbbba888abbba88889000000998abbbba8900000cc0c0cc000000000000998abbbba898aabba8900000000000000000000000000000000000
000000000098abbbbba8008abaa888aa8900000098abbbba890000000cccc0000000000000098abbbba88aaaaaa8900000000000000000000000000000000000
00000000098abbbbba8008aaa888aaa89999999098abbbba8900ccccccccc0000000999999098abbbba898888889000000999999000000000000000000000000
0000000098abbbbba80008a888aabba89888888998abbbba899999cccccccccc0999888888998abbbba88aaaaaa8900999888888900000000000000000000000
0000000098abbbba80000088aabbba888aaaaaa898abbbba8988888accccc9009888aaaaaa898abbbba88abbbba8909888aaaaaa890000000000000000000000
000000098abbbbba80008aaabbbba8aaabbbbbba88abbbba88aaaaaccbcbac998aaabbbbbba88abbbba88abbbba8998aaabbbbbba89000000000000000000000
00000098abbbbba80008aabbbbbaaabbbbbbbbba88abbbbaaabbbbccbbcba898abbbbbbabbba8abbbba88abbbba898abbbbbbabbba8900000000000000000000
00000098a3b3b3a8000088a3b3aab3b3b3b3b3ba88a3b3baaaabbcbbbbbba88abbbbbaa8aaaa8abbbba88abbbba88abbbbbaa8aaaa8900000000000000000000
0000098abbbbba800000008abba8aaaabbbabbba88abbbba888a3b3a3b3ba88a3b3ba88988888a3b3ba88ab3b3a88ab3b3a88988889000000000000000000000
0000098a3b3b3a800000008a3b3a88ab3b38ab3a88ab3b3a88abbba8abbba88abbbba89988888abbbba88abbbba88abbbba89988888900000000000000000000
000098a3b3b3ba80000088a3b3ba88a3b3a8a3ba88a3b3ba88a3b3a8a3b3a88ab3b3a898aaaa8ab3b3a88a3b3ba88a3b3ba898aaaa8900000000000000000000
000098a3333333a88888aa33333a8a333a88a33a88ab3b3a8a3b3a88ab3ba88a3b3ba898ab3a8a3b3ba88ab3b3a88ab3b3a898a3ba8900000000000000000000
000098a31313131aaaaa1313131a8a131a8a1313aaa3131a8a131a8a13131aa313131a8a13131a1313a88a3131a88a31313a8a313a8900000000000000000000
00098a313131313131313131313aa13131a1313131a1313a8a3131a131313131313131a131313a3131a88a1313a88a131313a3131a8900000000000000000000
00098a131313131313131313131aa31313131313aaa3131a8a13131313131aa313131313131aaa1313a88a3131a88a31313131313a8900000000000000000000
00098a313131313131313131313aa13131313131a8a1313a8a3131313131a88a313131313aa88a3131a88a1313a88a131313131aa89000000000000000000000
000098a313131313a31313131aa8a31313a3131a89a3131a8a13131a131a898a131313aaa8898a1313a88a3131a88a313131aaa8890000000000000000000000
000098a1313131aa8a3131aaa889a131aa8a31a899a13aa88a313aa8a1a8998a313aaa8889998a31aa898a13aa898a131aaa8889900000000000000000000000
0000098aaaaaaa888a13aa8889998aaa8898aa8909aaa88998aaa889aa890098aaa8889990098aaa88998aaa889098aaa8889990000000000000000000000000
00000098888888998aaa889990009888990988900988899009888990889000098889990000009888990098889900098889990000000000000000000000000000
00000009999999009888990000000999000099000099900000999000990000009990000000000999000009990000009990000000000000000000000000000000
00000000000000000999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000099000000990000099999900000009900990000099999900000000000000000000000000000000000000000000000000
00000000000000000000000000000000988998809889000988888890000098809889000988888890000000000000000000000000000000000000000000000000
000000000000000000000000000000098aa98aa98aa89098aaaaaa8900098aa98aa89098aaaaaa89000000000000000000000000000000000000000000000000
aaaaaaaaaaaaaaaaaaaaaaaaaaaaa098abb9abb9abba898abbbbbba89098abb8abba898abbbbbba890aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000
09999999999999999999999999999098abb9abb9abba898abbbbbba89098abb8abba898abbbbbba8909999999999999999999999999999900000000000000000
00999999999999999999999999999098a3b9a3b9a3ba8998aaaa3ba89098ab3b3b3a898a3baaaa89009999999999999999999999999999000000000000000000
00000000000000000000000000000098ab39ab39ab3a8999888ab3a89098a3b3b3ba898ab3888899000000000000000000000000000000000000000000000000
00222222222222222222222222222098a3b9a3b9a3ba898a3b3b3ba89098ab3aaaa8998a3b3b3ba8902222222222222222222222222222000000000000000000
00088888888888888888888888888098a339a339a33a898a333333a89098a33a8889098a333333a8908888888888888888888888888880000000000000000000
00008888888888888888888888888098a319a319a31a898a31aa31a89098a13a89900098aaaa31a8908888888888888888888888888800000000000000000000
00000000000000000000000000000098a139a139a13a898a130a13aa8998a31a89000009888a13a8900000000000000000000000000000000000000000000000
00000066666666666666666666666098a3131313131a898a31313131a898a13a8900098a313131a8906666666666666666666666660000000000000000000000
00000007777777777777777777777098a1313131313a898a13131313a898a31a8900098a131313a8907777777777777777777777700000000000000000000000
000000007777777777777777777770098aaaaaaaaaa89098aaaaaaaa89098aa890000098aaaaaa89007777777777777777777777000000000000000000000000
00000000000000000000000000000000988888888889000988888888900098890000000988888890000000000000000000000000000000000000000000000000
00000000000000000000000000000000099999999990000099999999000009900000000099999900000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
808182838485868788898a8b8c8d4d4e4f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
909192939495969798999a9b9c9d5d5e5f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a0a1a2a3a4a5a6a7a8a9aaabacad6d6e6f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b0b1b2b3b4b5b6b7b8b9babbbcbd7d7e7f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c0c1c2c3c4c5c6c7c8c9cacbcccd4a4b4c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d0d1d2d3d4d5d6d7d8d9dadbdcdd5a5b5c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e0e1e2e3e4e5e6e7e8e9eaebeced6a6b6c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000007a7b7c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100003b1703717035170311702c17027170201701b170131700f17009170031700117000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000001b670136700d6600a6500864007630046200261001600106000b60006600026000160034600326002f6002c600296002660023600206001c6001960017600116000d6000b60007600016000360000000
00040000017700177002770037600576007760097600b7600d760107501375016750177401874018740187401874018730187301873018720177201572013720107100e7100c7100b71008710067100571003710
0002000009170091700917009170091700a1700b1700e1700f1701217014170171701b1701f17023170271702b1702e1703017034170371703a1703c1703c1703c1703b1703717034170311702d1702a17027170
00050000130701306013050130401303011020100200e0100c0200a03007040040500106001070010600105001040010300102001010020000200002000020000200002000020000200002000020000200001000
000400000b0701067014070186701c0602066023060266602a0502d65030050306502f0402c640290402564023030206301a03016630130200f6200c020086200501001610010100100001000010000430000000
000800002a0502d05001000010002005001000250500100029060290602b0000100001000025002b5000250002500015000150001500015002a5000150001500015002a500015000150001500015003950039500
001000003e6703b66037650336402f6302b620286103e6003e600016000b60006600026000160034600326002f6002c600296002660023600206001c6001960017600116000d6000b60007600016000360000000
000500003855038550385503755035550305502a5502a550245501f5501955015550125500b550065500350002500015000150001500015000150001500385000150001500015003900039000390003900039000
0003000032670307702b67026770206701c7701867014770126700f7700d6700c7700a6700976007660057600475003650026500174001740016400163001630017200162001610016100170001700017000a700
01090000396703967039670386703666033660316502c6402a63025620216201461001610026000260002600026000260002600026002260021600206001e6001d6001c6001b6001a60019600186001860017600
00030b16042500525006250072500a2500d25013250172501f2502a2503325022550225500e5500e5500f550105501255014550195501c55020550184501c4501e4502145022450204501d4501a4501745016450
011000001f2351a00523235262353b2352e40037050103000b30007300073000100001000025002b5000250002500015000150001500015002a5000150001500015002a500015000150001500015003950039500
01100000132321a005172321a232232322e4001f252103000b30007300073000100001000025002b5000250002500015000150001500015002a5000150001500015002a500015000150001500015003950039500
011000000c0551c305130550c05518355100051000510005100051000510005100051000500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0006000018170000001d2701f0001f1700000024270000001f170000001d270000001817000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010600001f45000000184501f0001a450000001f450000001a4500000018450000001f45000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000400001f0502b05726050000002b050000002d05000000320503204032030320203201032000320003200032000320000000000000000000000000000000000000000000000000000000000000000000000000
0108000018250192501a2501b2501c2501b2501a25019250182500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0005000014550195001b5500000020550000001b5500000020550000002555000000205500000025550000002a550205000000000000000000000000000000000000000000000000000000000000000000000000
000400001f0702b07726070000002b070000002d07000000320703206032050320303201032000320003200032000320000000000000000000000000000000000000000000000000000000000000000000000000
011000002775020750277502c75020750000001b1000000020100000002510000000201000000025100000002a100197001970019700197001970019700000000000000000000000000000000000000000000000
000200001d77000000000000000035570000000000000000245700000000000000002b570000000000000000305700000000000000001b5700000000000000002057000000000000000000000000000000000000
000400001d77000000000003057035570000000000000000245700000000000295702b570000000000000000305700000000000000001b5003150000000000002050031500000000000000000000000000000000
010400000c450000000000000000000002b45000000000001845000000000002025000000000001d450000002b450000000000000000000000000000000000003045000000000000000000000000000000000000
000500000f5501950022550000001b55000000225500000027550000002c5500000027550000002c5500000031550205000000000000000000000000000000000000000000000000000000000000000000000000
0105000017150195001e1500000017150000001e1500000023150000002815000000231500000028150000002d150205000000000000000000000000000000000000000000000000000000000000000000000000
0005000016150195001d1500000016150000001d1500000022150000002715000000221500000027150000002c150205000000000000000000000000000000000000000000000000000000000000000000000000
01050000101501950023150000001c15000000231500000028150000002d1500000028150000002d1500000032150205000000000000000000000000000000000000000000000000000000000000000000000000
0110000014050130501205011050100500f0500e0500d050070520705207052070520705207052070520705207052070520705207052130021300213002130021300213002130021300213002130021300213002
010800000000000000000000000014050130501205011050100500f0500e0500d0500705207052070520705207052070520705207052070520705207052070520700207002070020700207002070020700200000
000100001307013070130701407015070180701a0701d0702007024070290702d07034070370703a0703c0703c0703d0703b07037070330702d070240701f0701907015070110700e0700c0700a0700907009070
00010000190700b0700c0700c0700e07011070170701d070220701e070150700d07009070090700a0700d07020070260702b0702b0700f0700a07008070080702107022070200701c0700a070090700907009070
011000201735500000173551735517355173051735517355183551830518355183551835500000183551835517355173051735517355173551d30517355173551d3551d0001d3551d3551d355000001d3551d355
011000200b455000000b4550b4550b455173050b4550b4550c455183050c4550c4550c455000000c4550c4550b455173050b4550b4550b4551d3050b4550b455114551d000114551145511455000001145511455
001000200e475000000e4750e4750e475173050e4750e4750f475183050f4750f4750f475000000f4750f4750e475173050e4750e4750e4751d3050e4750e475144751d000144751447514475000001447514475
001000200217500000021750217502175173050217502175031751830503175031750317500000031750317502175173050217502175021751d3050217502175081751d000081750817508175000000817508175
010d000021405000002d4052d4052140521405264053240521455000002d4052d4052145521455264550000021455000002645500000284522845228452000002d40000000000000000000000000000000000000
010d00001c205000002d4052d4051c2051c20521205324051c255000002d4052d4051c2551c25521255000001c255000002125500000232522325223252000002d40000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
04 0f104e44
04 13194e44
04 1c1a4344
01 23244344
02 21224344
02 21424344
00 41424344
04 25264344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 0f154e44
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
